--UNIT_AURA:player
function(allstates, event, ...)

    if allstates == nill then return false end
    if event ~= "UNIT_AURA" then return false end
    
    local unit, updateInfo = ...
    
    if not unit or unit ~= "player" then return false end
    
    local displayOnlyDispellableDebuffs = false;

    local function Debug(...)
        --print(...);
    end

    local function AuraFilter(aura)
        local spellId = aura.spellId;
        local spellName = aura.name;
        local whitelist = aura_env.whitelist[spellId];

        -- Ignore blacklisted auras
        if aura_env.blacklist[spellId] and aura_env.blacklist[spellId].enable == true then
            
            -- Whitelist can override blacklist
            if not whitelist or whitelist.enable == false then
                return false
            end
        end

        local isSelfCast = aura.sourceUnit == "player" or aura.sourceUnit == "pet"
        local isLust = aura_env.lust[spellId] and aura_env.lust[spellId].enable == true
        local isExternal = aura_env.external[spellId] and aura_env.external[spellId].enable == true
        local isDefensive = aura_env.defense[spellId] and aura_env.defense[spellId].enable == true
        local isRaidCd = aura_env.raidcd[spellId] and aura_env.raidcd[spellId].enable == true

        -- Ignore any non-personal auras unless they're externals / lust / raid CDs
        if not isSelfCast then
            if not isLust and not isExternal and not isRaidCd then
                if not whitelist or whitelist.enable == false then
                    --print("Skipping non-self cast:"..spellName)
                    return false
                end
            end
        else
            --print("Self cast:"..spellName)
            
            if not isDefensive and not isRaidCd then
                if not whitelist or whitelist.enable == false then
                    --print("Skipping self cast that is not defensive: "..spellId)
                    return false
                end
            end
        end

        -- Whitelisted auras are excluded from duration logic
        if not whitelist or whitelist.enable == false then
                                
            -- We ignore permanent auras that don't have  duration e.g. Timewalking buff
            if not aura.duration or aura.duration == 0 or aura.duration < 1 then return false; end
            
            -- Ignore any particularly long buffs, over 2mins
            if aura.duration and aura.duration > 120 then return false; end
        end

		return true;
    end

    local function ProcessAura(aura, allstates, added)
        -- for i,v in pairs(aura) do 
        --     Debug("    "..tostring(i).."="..tostring(v));
        -- end

        if(not AuraFilter(aura)) then return; end

        local spellId = aura.spellId;

        local isSelfCast = aura.sourceUnit == "player" or aura.sourceUnit == "pet"
        local isLust = aura_env.lust[spellId] and aura_env.lust[spellId].enable == true
        local isExternal = aura_env.external[spellId] and aura_env.external[spellId].enable == true
        local isDefensive = aura_env.defense[spellId] and aura_env.defense[spellId].enable == true
        local isRaidCd = aura_env.raidcd[spellId] and aura_env.raidcd[spellId].enable == true
        
        if not isSelfCast and added then
            -- Only play sound when the aura is first applied, so we don't get spammed
            local volume = C_CVar.GetCVar("Sound_DialogVolume") * C_CVar.GetCVar("Sound_MasterVolume") * 100
            C_VoiceChat.SpeakText(0, aura.name, Enum.VoiceTtsDestination.LocalPlayback, 0, volume)
        end

        allstates[aura.auraInstanceID] = {
            changed = true,
            show = true,
            progressType = "timed",
            unit = "player",
            autoHide = false,
            auraInstanceID = aura.auraInstanceID,
            unitAuraInstanceID = aura.auraInstanceID,
            unitAuraFilter = "HELPFUL",
            unitBuffIndex = index,
            buffType = aura.dispelName,
            filter = "HELPFUL",

            -- Custom variables
            isSelfCast = isSelfCast,
            isLust = isLust,
            isExternal = isExternal,
            isDefensive = isDefensive,
            isRaidCd = isRaidCd,
    
            --spellId= aura.spellId,
            name = aura.name,
            icon = aura.icon,
            applications = aura.applications,
            stacks = aura.applications,
            dispelName = aura.dispelName,
            duration = aura.duration,
            expirationTime= aura.expirationTime,
            sourceUnit= WA_ClassColorName(aura.sourceUnit),
            isStealable= aura.isStealable,
            nameplateShowPersonal= aura.nameplateShowPersonal,
            nameplateShowAll=aura.nameplateShowAll,
            
            isHarmful = aura.isHarmful,
            isHelpful = aura.isHelpful,
            canApplyAura= aura.canApplyAura,
            isBossAura= aura.isBossAura,
            isFromPlayerOrPlayerPet= aura.isFromPlayerOrPlayerPet,    
            timeMod = aura.timeMod        
        }
    end

    local function ProcessAllAuras(allstates)
        local batchCount = nil;
        local usePackedAura = true;
    
        local function HandleAura(aura)
            local displayOnlyDispellableDebuffs = false;
            local ignoreBuffs = false;
            local ignoreDebuffs = true;
            local ignoreDispelDebuffs = true;
    
            local type = AuraUtil.ProcessAura(aura, displayOnlyDispellableDebuffs, ignoreBuffs, ignoreDebuffs, ignoreDispelDebuffs);
            
            if type == AuraUtil.AuraUpdateChangedType.Buff then
                ProcessAura(aura, allstates);
            end
        end

        Debug("ProcessAllAuras");
        AuraUtil.ForEachAura(unit, AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Helpful), batchCount, HandleAura, usePackedAura);
    end

    local function UpdateAuras(unitAuraUpdateInfo, allstates)
        
        local aurasChanged = false;
    
        if unitAuraUpdateInfo == nil or unitAuraUpdateInfo.isFullUpdate then
            Debug("FULL UPDATE")
            for _,state in pairs(allstates) do
                state.show = false
                state.changed = true
            end
            ProcessAllAuras(allstates);
            aurasChanged = true;
        else
            -- Added auras
            if unitAuraUpdateInfo.addedAuras ~= nil then
                for _, aura in ipairs(unitAuraUpdateInfo.addedAuras) do
                    if aura.isHelpful then
                        Debug("Added Aura:"..aura.name)
                        ProcessAura(aura, allstates, true)
                        aurasChanged = true;
                    end
                end
            end
        
            -- Updated auras
            if unitAuraUpdateInfo.updatedAuraInstanceIDs ~= nil then
                for _, auraInstanceID in ipairs(unitAuraUpdateInfo.updatedAuraInstanceIDs) do
                    local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
                    if aura and aura.isHelpful then
                        Debug("Updated Aura:"..aura.name)
                        ProcessAura(aura, allstates)
                        aurasChanged = true;
                    end
                end
            end
        
            -- Removed auras
            if unitAuraUpdateInfo.removedAuraInstanceIDs ~= nil then
                for _, auraInstanceID in ipairs(unitAuraUpdateInfo.removedAuraInstanceIDs) do
                    if allstates[auraInstanceID] ~= nil then
                        Debug("Removed Aura:"..auraInstanceID)
                        allstates[auraInstanceID].changed = true
                        allstates[auraInstanceID].show = false
                        aurasChanged = true;
                    end
                end
            end
        end
    
        return aurasChanged;
    end
    
    -- EVENT HANDLER
    if event == "UNIT_AURA" then
        local aurasChanged = UpdateAuras(updateInfo, allstates);
        return aurasChanged;
    end
end
