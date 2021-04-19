--UNIT_AURA CLEU:SPELL_AURA_APPLIED:SPELL_AURA_REFRESH:SPELL_AURA_APPLIED_DOSE:SPELL_AURA_REMOVED_DOSE:SPELL_AURA_REMOVED
function(allstates, event, ...)

    local _log = function(...)
        if aura_env and aura_env.config and aura_env.config.enableDebug == true then
            print(...);
        end
    end

    if event == "UNIT_AURA" then
        if allstates == nil then return false end
        local unit = ...
        if not unit or not unit == "player" then return false end
        if not WeakAuras.myGUID then return false end

        -- Update auras
        aura_env.refreshAuras(allstates);

        return true;
    end

    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, auraType = ...     

        if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REFRESH" or subEvent == "SPELL_AURA_REMOVED_DOSE" then    
            if UnitIsPlayer(destName) and UnitIsUnit(destName, "player") then
                if auraType == "HARMFUL" or auraType == "DEBUFF" then
                    
                    _log(subEvent.." "..spellName);

                    local whitelist = aura_env.whitelist[spellID]

                    -- Ignore blacklisted debuffs
                    if aura_env.blacklist and aura_env.blacklist[spellID] and aura_env.blacklist[spellID].enable == true then
                        
                        -- Whitelist can override blacklist
                        if not whitelist or whitelist.enable == false then
                            _log("Ignoring blacklisted spell: "..spellName);
                            return true
                        end
                    end

                    aura_env.refreshAuras(allstates, spellID);

                    return true;
                end
            end            
        end
        
        if subEvent == "SPELL_AURA_REMOVED" and (auraType == "HARMFUL" or auraType == "DEBUFF") then
            if UnitIsPlayer(destName) and UnitIsUnit(destName, "player") then
                _log(subEvent.." "..spellName);

                if allstates[spellID..destGUID] then
                    allstates[spellID..destGUID].changed = true
                    allstates[spellID..destGUID].show = false
                    return true
                end
            end
        end
        
    end
end