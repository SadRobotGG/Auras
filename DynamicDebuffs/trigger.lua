--UNIT_AURA CLEU:SPELL_AURA_APPLIED:SPELL_AURA_REFRESH:SPELL_AURA_APPLIED_DOSE:SPELL_AURA_REMOVED_DOSE:SPELL_AURA_REMOVED
function(allstates, event, ...)

    if event == "UNIT_AURA" then
        if allstates == nil then return false end
        local unit = ...
        if not unit or not unit == "player" then return false end
        if not WeakAuras.myGUID then return false end

        -- Update auras
        local auraIndex = 1
        while true do
            local _, _, stacks, _, duration, expirationTime, _, _, _, spellId = UnitAura(unit, auraIndex, "HARMFUL")
            if not spellId then break end

            if allstates[spellId..WeakAuras.myGUID] then
                allstates[spellId..WeakAuras.myGUID].stacks = stacks;
                allstates[spellId..WeakAuras.myGUID].expirationTime = expirationTime;
                allstates[spellId..WeakAuras.myGUID].duration = duration;
                allstates[spellId..WeakAuras.myGUID].unitDebuffIndex = auraIndex;
                allstates[spellId..WeakAuras.myGUID].changed = true;
            end

            auraIndex = auraIndex + 1
        end
    end

    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, auraType = ...
        
        if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REFRESH" or subEvent == "SPELL_AURA_REMOVED_DOSE" then    
            if UnitIsPlayer(destName) and UnitIsUnit(destName, "player") then
                if auraType == "HARMFUL" or auraType == "DEBUFF" then
                    
                    -- Ignore blacklisted debuffs
                    if aura_env.blacklist and aura_env.blacklist[spellID] and aura_env.blacklist[spellID].enable == true then
                        return false
                    end
                    
                    -- Manually find the debuff so we can get access to all properties
                    local i = 1;
                    while true do
                        local spellName, icon, stacks, auraType, duration, expirationTime, _, _, _, id = UnitAura(destName, i, "HARMFUL")
                        
                        if not spellName then return true end
                        
                        -- Found our matching debuff?
                        if id == spellID then
                            
                            allstates[spellID..destGUID] = {
                                changed = true,
                                show = true,
                                name = WA_ClassColorName(destName),
                                icon = icon,
                                stacks = stacks,
                                progressType = "timed",
                                expirationTime = expirationTime,
                                duration = duration,
                                spellID = spellID,
                                autoHide = true,
                                unit = "player",
                                unitDebuffIndex = i,
                                debuffType = debuffType
                            }
                            
                            -- If we're at 0 doses then we can remove
                            if subEvent == "SPELL_AURA_DOSE_REMOVED" and stacks == 0 then
                                allstates[spellID..destGUID].show = false
                            end
                            
                            return true
                        end

                        i = i + 1;
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