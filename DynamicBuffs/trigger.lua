--CLEU:SPELL_AURA_APPLIED:SPELL_AURA_REFRESH:SPELL_AURA_APPLIED_DOSE:SPELL_AURA_REMOVED_DOSE:SPELL_AURA_REMOVED
function(allstates, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, auraType = ...
        
        if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REFRESH" or subEvent == "SPELL_AURA_REMOVED_DOSE" then    
            if UnitIsPlayer(destName) and UnitIsUnit(destName, "player") then
                if auraType == "HELPFUL" or auraType == "BUFF" then
                    
                    -- Ignore blacklisted auras
                    if aura_env.blacklist[spellID] and aura_env.blacklist[spellID].enable == true then
                        return true
                    end
                    
                    -- Manually find the aura so we can get access to all properties
                    for i = 1, 255 do                    
                        local _, icon, stacks, auraType, duration, expirationTime, _, _, _, id = UnitAura(destName, i, "HELPFUL")
                        
                        -- Found our matching aura?
                        if id == spellID then
                            
                            -- We ignore permanent auras that don't have  duration e.g. Timewalking buff
                            if not duration then return true end

                            allstates[spellID..destGUID] = {
                                changed = true,
                                show = true,
                                name = WA_ClassColorName(sourceName),
                                icon = icon,
                                stacks = stacks,
                                progressType = "timed",
                                expirationTime = expirationTime,
                                duration = duration,
                                spellId = spellID,
                                autoHide = true,
                                unit = "player",
                                unitBuffIndex = i,
                                auraType = auraType
                            }
                            
                            -- If we're at 0 doses then we can remove
                            if subEvent == "SPELL_AURA_DOSE_REMOVED" and stacks == 0 then
                                allstates[spellID..destGUID].show = false
                            end
                            
                            return true
                        end
                    end               
                end
            end            
        end
        
        if subEvent == "SPELL_AURA_REMOVED" then
            if allstates[spellID..destGUID] then
                allstates[spellID..destGUID].changed = true
                allstates[spellID..destGUID].show = false
                return true
            end
        end
        
    end
end

