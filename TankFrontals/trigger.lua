function(states, event, ...)

    -- When we leave combat, clear states
    if event == "PLAYER_REGEN_ENABLED" then
        for _,state in pairs(states) do
            state.show = false
            state.changed = true
        end
        aura_env.unitTargetScans = {}
        return true
    end

    if event == "UNIT_SPELLCAST_START" then

        local sourceUnit, castGuid, spellId = ...

        local spellInfo = aura_env.spells[spellId]

        if spellInfo then

            -- Ignored spells
            if spellInfo.disabled == true then return true end

            -- Ignore "target" as we'll get an event for the nameplate unit anyway
            if sourceUnit == "target" or sourceUnit == "softtarget" then return true end

            -- If we're not in combat, ignore
            if not UnitAffectingCombat("player") then return true end

            -- We're not interested in units that don't exist, or we're not in combat with
            if not sourceUnit or not UnitExists(sourceUnit) or not UnitAffectingCombat(sourceUnit) then
                DebugPrint("Not in combat with "..sourceUnit)
                return true
            end

            -- Only units hostile to us
            if not UnitIsEnemy(sourceUnit, "player") then
                DebugPrint("Not hostile to "..sourceUnit)
                return true
            end

            local targetTimer = (spellInfo.targetTimer or 0.2)
            if targetTimer < 0.2 then
                targetTimer = 0.2
            end

            local payload = {
                guid = castGuid,
                info = spellInfo,
                type = aura_env.types[spellInfo.type],
                spellId = spellId,
                isTarget = UnitIsUnit("player", sourceUnit.."target"),
                isTank = aura_env.isTank,
                sourceUnit = sourceUnit,
                sourceName = GetUnitName(sourceUnit),
                destinationName = GetUnitName(sourceUnit.."target"),
                startTime = GetTime(),
                name = spellInfo.name,
                targetTimer = targetTimer
            }

            local config = aura_env.isTank and aura_env.config.tankDefaults or aura_env.config.otherDefaults

            local function DisplayFrontal(states, payload)

                if( config[3] and payload.type and payload.type.textToSpeech ) then
                    local volume = C_CVar.GetCVar("Sound_DialogVolume") * C_CVar.GetCVar("Sound_MasterVolume") * 100
                    C_VoiceChat.SpeakText(0, payload.type.textToSpeech, Enum.VoiceTtsDestination.LocalPlayback, 0, volume)
                end

                if( config[2] and payload and payload.type and payload.type.sound ) then
                    local willPlay, soundHandle = PlaySoundFile(payload.type.sound, "Dialog")
                end

                local cachedInfo = C_Spell.GetSpellInfo(payload.spellId)
                local castTime = payload.info.duration
                if cachedInfo.castTime then
                    castTime = cachedInfo.castTime / 1000
                end
                --print("Actual castTime: "..cachedInfo.castTime)

                states[payload.guid] = {
                    show = true,
                    name = payload.name,
                    changed = true,
                    autoHide = true,
                    progressType = "timed",
                    duration = castTime,
                    expirationTime = payload.startTime + castTime,
                    icon = payload.info.icon,
                    type = payload.info.type,
                    isTarget = payload.isTarget,
                    isTank = payload.isTank,
                    spellId = payload.spellId,
                    sourceUnit = payload.sourceUnit,
                    sourceName = payload.sourceName,
                    destinationName = payload.destinationName,
                }

                -- Hide the progress bar unless it's enabled for our current role
                if not config[4] then
                    states[payload.guid].show = false
                end

                return true
            end

            local function SayFrontal(payload)

                if not config[1] then
                    return false
                end

                -- Check we're the target
                if payload.isTarget then
                    local message = payload.info.message or payload.type.message or (">> "..toupper(payload.type.name).." ON ME <<")
                    local caption =  message:format(payload.sourceName, payload.info.name, payload.destinationName)
                    SendChatMessage(caption, "SAY")
                else
                    DebugPrint(payload.type.name.." ON "..(payload.destinationName or "Unknown"))
                end

                return true
            end

            DisplayFrontal(states, payload)

            -- Do we need to scan for the target?
            if spellInfo.target == aura_env.TargetDetection.Scan then
                DebugPrint("Checking target: "..spellInfo.target.." for "..tostring(targetTimer))
                -- local spec, role, pos = WeakAuras.SpecRolePositionForUnit("player")
                
                local FireTrigger = function(payload, elapsed)
                    DebugPrint("Targetted: "..(payload.destinationName or "Unknown").." ".. (payload.destinationUnit or "Unknown").." "..elapsed)
                    SayFrontal(payload)
                end

                aura_env.GetUnitTarget(FireTrigger, payload)
            else
                SayFrontal(payload)
            end
            
        end
    end

    return true
end