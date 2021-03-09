function(states, event, sourceGuid, subevent, _, _, sourceName, _, _, _, destName, _, _, spellID)
    local spells = aura_env.spells
    
    if spells[subevent] then
        
        local spellInfo = spells[subevent][spellID]
        if spellInfo then
            
            -- If it's a tareted spell but we're not the target, do nothing
            if destName then
                if not UnitIsPlayer(destName) or not UnitIsUnit(destName, "player") then
                    return true
                end
            end           
            
            if WeakAuras.CurrentEncounter and WeakAuras.CurrentEncounter.boss_guids then
                for i = 1, 5 do
                    local sourceUnit = "boss"..i
                    if (UnitExists(sourceUnit)) then
                        local unitName = UnitName(sourceUnit)
                        if unitName and unitName == sourceName then
                            -- Spell is from this boss. Only announce if we have aggro.
                            local status = UnitThreatSituation("player", sourceUnit) or -1;
                            local aggro = status == 2 or status == 3;
                            if not aggro then
                                -- We don't have aggro, so announce nothing
                                return true
                            else
                                -- We have aggro, break from the loop so we can announce
                                break
                            end
                        end
                    end
                end
            end
            
            local caption = aura_env.captions[spellInfo[2]]:format(sourceName)
            states[spellID] = {
                show = true,
                name = caption,
                changed = true,
                autoHide = true,
                progressType = "timed",
                duration = spellInfo[1],
                expirationTime = GetTime() + spellInfo[1],
                icon = GetSpellTexture(spellID)
            }
        end
    end
    
    return true
end

