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
            local _, _, stacks, _, duration, expirationTime, _, _, _, spellId = UnitAura(unit, auraIndex, "HELPFUL")
            if not spellId then break end

            if allstates[spellId..WeakAuras.myGUID] then
                allstates[spellId..WeakAuras.myGUID].stacks = stacks;
                allstates[spellId..WeakAuras.myGUID].expirationTime = expirationTime;
                allstates[spellId..WeakAuras.myGUID].duration = duration;
                allstates[spellId..WeakAuras.myGUID].unitBuffIndex = auraIndex;
                allstates[spellId..WeakAuras.myGUID].changed = true;
            end

            auraIndex = auraIndex + 1
        end
    end

    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local _, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, _, auraType = ...
        
        if subEvent == "SPELL_AURA_APPLIED" or subEvent == "SPELL_AURA_APPLIED_DOSE" or subEvent == "SPELL_AURA_REFRESH" or subEvent == "SPELL_AURA_REMOVED_DOSE" then
            if UnitIsPlayer(destName) and UnitIsUnit(destName, "player") then
                if auraType == "HELPFUL" or auraType == "BUFF" then
                    
                    -- Ignore blacklisted auras
                    if aura_env.blacklist[spellId] and aura_env.blacklist[spellId].enable == true then
                        return true
                    end
                    
                    -- Manually find the aura so we can get access to all properties
                    local i = 1;
                    while true do
                        local spellName, icon, stacks, auraType, duration, expirationTime, _, _, _, id = UnitAura(destName, i, "HELPFUL")
                        
                        if not spellName then return true end

                        -- Found our matching aura?
                        if id == spellId then
                            
                            -- We ignore permanent auras that don't have  duration e.g. Timewalking buff
                            if not duration or duration == 0 or duration < 1 then

                                -- TODO: support whitelisting, and whitelisting by stacks e.g. Bron arriving soon
                                return true;
                            end

                            allstates[spellId..destGUID] = {
                                changed = true,
                                show = true,
                                name = WA_ClassColorName(sourceName),
                                icon = icon,
                                stacks = stacks,
                                progressType = "timed",
                                expirationTime = expirationTime,
                                duration = duration,
                                spellId = spellId,
                                autoHide = true,
                                unit = "player",
                                unitBuffIndex = i,
                                auraType = auraType
                            }
                            
                            -- If we're at 0 doses then we can remove
                            if subEvent == "SPELL_AURA_DOSE_REMOVED" and stacks < 1 then
                                allstates[spellId..destGUID].show = false
                            end
                            
                            return true
                        end

                        i = i + 1;
                    end
                end
            end
        end

        if subEvent == "SPELL_AURA_REMOVED" then
            if allstates[spellId..destGUID] then
                allstates[spellId..destGUID].changed = true
                allstates[spellId..destGUID].show = false
                return true
            end
        end
        
    end
end

