function(states, event, sourceGuid, subevent, _, _, sourceName, _, _, _, destName, _, _, spellID)
    local spells = aura_env.spells
    
    if spells[subevent] then
        
        local spellInfo = spells[subevent][spellID]
        if spellInfo then
            
            local casterName = nil
            if sourceName ~= "player" then
                casterName = WA_ClassColorName(sourceName)
            end

            local caption = spellInfo[2] .. GetSpellInfo(spellID)

            states[spellID] = {
                show = true,
                name = caption,
                changed = true,
                autoHide = true,
                progressType = "timed",
                duration = spellInfo[1],
                expirationTime = GetTime() + spellInfo[1],
                icon = GetSpellTexture(spellID),
                casterName = casterName
            }
        end
    end
    
    return true
end

