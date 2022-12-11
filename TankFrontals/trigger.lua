function(states, event, sourceUnit, sourceGuid, spellID)

    local debug = false

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

            -- We're not interested in units that don't exist, or we're not in combat with
            if not sourceUnit or not UnitExists(sourceUnit) or not UnitAffectingCombat(sourceUnit) then
                if debug then print("Not in combat with "..sourceUnit) end
                return true
            end
            
            -- Only units hostile to us
            if not UnitIsEnemy(sourceUnit, "player") then
                if debug then print("Not hostile to "..sourceUnit) end
                return true
            end

            -- Only if we're the target
            if not UnitIsUnit("player", sourceUnit.."target") then
                if debug then print("Not a target of "..sourceUnit) end
                return true
            end

            local sourceName = GetUnitName(sourceUnit)
            local destinationName = GetUnitName(sourceUnit.."target")
            
            local caption = (spellInfo.caption or aura_env.captions[spellInfo.type]):format(sourceName, spellInfo.name, destinationName)

            states[spellID] = {
                show = true,
                name = caption,
                changed = true,
                autoHide = true,
                progressType = "timed",
                duration = spellInfo.duration,
                expirationTime = GetTime() + spellInfo.duration,
                icon = GetSpellTexture(spellID)
            }
        end
    end
 
    return true
end