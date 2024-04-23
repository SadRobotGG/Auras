function(states, event, sourceUnit, sourceGuid, spellID)

    -- When we leave combat, clear states
    if event == "PLAYER_REGEN_ENABLED" then
        for _,state in pairs(states) do
            state.show = false
            state.changed = true
        end
        return true
    end

    local spells = aura_env.spells

    if spells[event] then

        local spellInfo = spells[event][spellID]
        if spellInfo then

            -- Ignored spells
            if spellInfo.enabled == false then return true end

            -- Ignore "target" as we'll get an event for the nameplate unit anyway
            if sourceUnit == "target" then return true end

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

            local ignoreTarget = spellInfo.ignoreTarget == true or type == "PURGE" or type == "SOOTHE" or type == "SOOTHE_SPELL" or type == "PURGE_SPELL";
            local isTarget = UnitIsUnit("player", sourceUnit.."target");
            local isTank = select(5, GetSpecializationInfo(GetSpecialization())) == "TANK";
            local type = spellInfo.type or "FRONTAL"
            local sourceName = GetUnitName(sourceUnit)
            local destinationName = GetUnitName(sourceUnit.."target")

            local caption = aura_env.captions[type]:format(sourceName, spellInfo.name, destinationName)

            states[spellID] = {
                show = true,
                name = caption,
                changed = true,
                autoHide = true,
                progressType = "timed",
                duration = spellInfo.duration,
                expirationTime = GetTime() + spellInfo.duration,
                icon = GetSpellTexture(spellID),
                type = type,
                isTarget = isTarget,
                isTank = isTank,
                ignoreTarget = ignoreTarget
            }
        end
    end

    return true
end