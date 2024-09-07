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

    local DebuffType = EnumUtil.MakeEnum(
        "None",
        "Magic",
        "Curse",
        "Disease",
        "Poison"
    );

    local dispels = {
    
        -- Druid
        [102] = {magic = false, curse = true, poison = true, disease = false }, -- Balance
        [103] = {magic = false, curse = true, poison = true, disease = false }, -- Feral
        [104] = {magic = false, curse = true, poison = true, disease = false }, -- Guardian
        [105] = {magic = true,  curse = true, poison = true, disease = false }, -- Restoration
    
        -- Evoker
        [1467] = {magic = false, curse = false, poison = true, disease = false }, -- Devastation
        [1468] = {magic = true, curse = false, poison = true, disease = false }, -- Preservation
        [1473] = {magic = false, curse = false, poison = true, disease = false }, -- Augmentation

        -- Mage
        [62]  = {magic = false, curse = true, poison = false, disease = false }, -- Arcane
        [63]  = {magic = false, curse = true, poison = false, disease = false }, -- Fire
        [64]  = {magic = false, curse = true, poison = false, disease = false }, -- Frost
        
        -- Monk
        [268] = {magic = false, curse = false, poison = true, disease = true }, -- Brewmaster
        [269] = {magic = false, curse = false, poison = true, disease = true }, -- Windwalker
        [270] = {magic = true,  curse = false, poison = true, disease = true }, -- Mistweaver
        
        -- Paladin
        [65]  = {magic = true,  curse = false, poison = true, disease = true }, -- Holy
        [66]  = {magic = false, curse = false, poison = true, disease = true }, -- Protection
        [70]  = {magic = false, curse = false, poison = true, disease = true }, -- Retribution
    
        -- Priest
        [256] = {magic = true,  curse = false, poison = false, disease = true }, -- Discipline
        [257] = {magic = true,  curse = false, poison = false, disease = true }, -- Holy
        [258] = {magic = true,  curse = false, poison = false, disease = true }, -- Shadow
    
        -- Shaman
        [262] = {magic = false, curse = true, poison = false, disease = false }, -- Elemental
        [263] = {magic = false, curse = true, poison = false, disease = false }, -- Enhancement
        [264] = {magic = true,  curse = true, poison = false, disease = false }, -- Restoration
    
        -- Warlock TODO: Singe Magic
        [265] = {magic = false, curse = false, poison = false, disease = false }, -- Affliction
        [266] = {magic = false, curse = false, poison = false, disease = false }, -- Demonology
        [267] = {magic = false, curse = false, poison = false, disease = false }, -- Destruction
    }

    -- local dispels = {
    
           
    --     -- Evoker
    --     [1467] = {poison = [365585]}, -- Devastation
    --     [1468] = {magic = [374251], curse = false, poison = [374251,365585], disease = false, spellId = 374251 },   -- Preservation
    --     [1473] = {poison = [365585]}, -- Augmentation

    --     -- Mage
    --     [62]  = {magic = false, curse = true, poison = false, disease = false, spellId = 475 }, -- Arcane
    --     [63]  = {magic = false, curse = true, poison = false, disease = false, spellId = 475 }, -- Fire
    --     [64]  = {magic = false, curse = true, poison = false, disease = false, spellId = 475 }, -- Frost
        
    --     -- Monk
    --     [268] = {magic = false, curse = false, poison = true, disease = true, spellId = 218164 }, -- Brewmaster
    --     [269] = {magic = false, curse = false, poison = true, disease = true, spellId = 218164 }, -- Windwalker
    --     [270] = {magic = true,  curse = false, poison = true, disease = true, spellId = 218164 }, -- Mistweaver
        
    --     -- Paladin
    --     [65]  = { magic = [4987], poison = [4987], disease = [4987] }, -- Holy
    --     [66]  = { poison = [213644], disease = [213644] }, -- Protection
    --     [70]  = { poison = [213644], disease = [213644] }, -- Retribution
    
    --     -- Priest
    --     [256] = {magic = [527 /* Dispel Magic */, 32375 /* Mass Dispel */], disease = [527] }, -- Discipline
    --     [257] = {magic = [527 /* Dispel Magic */, 32375 /* Mass Dispel */], disease = [527] }, -- Holy
    --     [258] = {magic = [528 /* Dispel Magic */, 32375 /* Mass Dispel */], disease = [213634] }, -- Shadow
    
    --     -- Shaman
    --     [262] = {curse = [51886], poison = [383013] /* Poison Cleansing Totem */ }, -- Elemental
    --     [263] = {curse = [51886], poison = [383013] /* Poison Cleansing Totem */ }, -- Enhancement
    --     [264] = {curse = [51886], poison = [383013] /* Poison Cleansing Totem */, magic = [77130] }, -- Restoration
    
    --     -- Warlock TODO: Singe Magic
    --     [265] = {curse = [115276] }, -- Affliction
    --     [266] = {curse = [115276] }, -- Demonology
    --     [267] = {curse = [115276] }, -- Destruction
    -- }
    
    local className, classFilename, classId = UnitClass(unit)
    local specIndex = GetSpecialization();
    local specializationId, name, description, icon, role, primaryStat = GetSpecializationInfo(specIndex);

    local function CanDispel(type)
        
        return type and dispels and dispels[specializationId] and dispels[specializationId][ string.lower(type) ] == true;

        -- Debug("CanDispel:"..type);
        -- local auraType = DebuffType[type];

        -- Debug("auraType:"..auraType);

        -- if not auraType or auraType == DebuffType.None then return false; end        

        -- -- 1 	Warrior 	WARRIOR 	
        -- -- 2 	Paladin 	PALADIN 	
        -- -- 3 	Hunter 	HUNTER 	
        -- -- 4 	Rogue 	ROGUE 	
        -- -- 5 	Priest 	PRIEST 	
        -- -- 6 	Death Knight 	DEATHKNIGHT 	Added in 3.0.2
        -- -- 7 	Shaman 	SHAMAN 	
        -- -- 8 	Mage 	MAGE 	
        -- -- 9 	Warlock 	WARLOCK 	
        -- -- 10 	Monk 	MONK 	Added in 5.0.4
        -- -- 11 	Druid 	DRUID 	
        -- -- 12 	Demon Hunter 	DEMONHUNTER 	Added in 7.0.3
        -- -- 13 	Evoker 	EVOKER 	Added in 10.0.0

        -- -- Druid
        -- if classId == 11 then
        --     -- 2782 = Remove Corruption, 88423 = Nature's Cure, 392378 = Improved Nature's Cure to allow dispelling Poison and Curse
        --     if auraType == "curse" and (IsPlayerSpell(2782) or (IsPlayerSpell(88423) and IsPlayerSpell(392378))) then return true; end
        --     if auraType == "poison" and (IsPlayerSpell(2782) or (IsPlayerSpell(88423) and IsPlayerSpell(392378))) then return true; end
        --     if auraType == "magic" and IsPlayerSpell(88423) then return true; end
        
        -- -- Evoker
        -- elseif classId == 13 then
        --     -- 374258 Cauterizing Flame works for all but magic (including bleeds)
        --     if( auraType ~= "magic" and IsPlayerSpell(374258) ) then return true; end

        --     -- 365585 Expunge is for Poison, and for Magic if Preservation
        --     if auraType == "poison" and IsPlayerSpell(365585) then return true; end

        --     -- 365585 Expunge works for Magic too if Preservation
        --     if auraType == "magic" and specialization==1468 and IsPlayerSpell(365585) then return true; end

        -- -- Paladin
        -- elseif classId == 2 then
        --     Debug("Checking paladin");
        --     if specializationId == 65 then
        --         -- Holy (Cleanse)
        --         Debug("Checking Holy");
        --         return IsPlayerSpell(4987) and (auraType == DebuffType.Disease or auraType == DebuffType.Poison or auraType == DebuffType.Magic)
        --     else
        --         Debug("Checking Prot/Ret");
        --         local check = IsPlayerSpell(213644) and (auraType == DebuffType.Disease or auraType == DebuffType.Poison);
        --         Debug("Check:"..tostring(check));
        --         return check;
        --     end
        -- end

        -- return false;
    end

    local function AuraFilter(aura)
        local spellId = aura.spellId;        
        local whitelist = aura_env.whitelist[spellId];

        -- Ignore blacklisted auras
        if aura_env.blacklist[spellId] and aura_env.blacklist[spellId].enable == true then
            
            -- Whitelist can override blacklist
            if not whitelist or whitelist.enable == false then
                return false
            end
        end

		return true;
    end

    local function ProcessAura(aura, allstates)
        -- for i,v in pairs(aura) do 
        --     Debug("    "..tostring(i).."="..tostring(v));
        -- end

        if(not AuraFilter(aura)) then return; end

        local isDispellable = aura.dispelName and CanDispel(aura.dispelName);

        -- Get the debuff index
        local index = 1;
        while true do
            local match = C_UnitAuras.GetAuraDataByIndex(unit, index, "HARMFUL")
            if not match then break end
            if match.auraInstanceID == aura.auraInstanceID then break end
            index = index + 1
        end
        
        allstates[aura.auraInstanceID] = {
            changed = true,
            show = true,
            progressType = "timed",
            unit = "player",
            autoHide = false,
            auraInstanceID = aura.auraInstanceID,
            unitDebuffIndex = index,
            debuffType = aura.dispelName,
            filter = "HARMFUL",

            -- Custom variables
            isDispellable = isDispellable,
    
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
            local ignoreBuffs = true;
            local ignoreDebuffs = false;
            local ignoreDispelDebuffs = false;
    
            local type = AuraUtil.ProcessAura(aura, displayOnlyDispellableDebuffs, ignoreBuffs, ignoreDebuffs, ignoreDispelDebuffs);
            
            if type == AuraUtil.AuraUpdateChangedType.Debuff or type == AuraUtil.AuraUpdateChangedType.Dispel then
                ProcessAura(aura, allstates);
            end
        end

        Debug("ProcessAllAuras");
        AuraUtil.ForEachAura(unit, AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful), batchCount, HandleAura, usePackedAura);
        -- AuraUtil.ForEachAura(unit, AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful, AuraUtil.AuraFilters.Raid), batchCount, HandleAura, usePackedAura);
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
                    if aura.isHarmful then
                        Debug("Added Aura:"..aura.name)
                        ProcessAura(aura, allstates)
                        aurasChanged = true;
                    end
                end
            end
        
            -- Updated auras
            if unitAuraUpdateInfo.updatedAuraInstanceIDs ~= nil then
                for _, auraInstanceID in ipairs(unitAuraUpdateInfo.updatedAuraInstanceIDs) do
                    local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(unit, auraInstanceID)
                    if aura and aura.isHarmful then
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
