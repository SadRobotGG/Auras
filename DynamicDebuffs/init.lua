-- Custom options
local c = aura_env.config;

local _log = function(...)
    if aura_env and aura_env.config and aura_env.config.enableDebug == true then
        print(...);
    end
end

local dispels = {
    
    -- Druid
    [102] = {magic = false, curse = true, poison = true, disease = false }, -- Balance
    [103] = {magic = false, curse = true, poison = true, disease = false }, -- Feral
    [104] = {magic = false, curse = true, poison = true, disease = false }, -- Guardian
    [105] = {magic = true,  curse = true, poison = true, disease = false }, -- Restoration

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

local className, classFilename, classId = UnitClass("player")
local specIndex = GetSpecialization();
local specializationId, name, description, icon, role, primaryStat = GetSpecializationInfo(specIndex);

aura_env.specializationId = specializationId;

aura_env.canDispel = function(auraType)
    return auraType and dispels and dispels[specializationId] and dispels[specializationId][ string.lower(auraType) ] == true;
end

local function Defaults(priorityOverride)
	return {
		enable = true,
		priority = priorityOverride or 0,
		stackThreshold = 0
	}
end

aura_env.whitelist = {
    [335586] = { enable = true, priority = 0, stackThreshold = 1}, -- Immediate Extermination (Eye of the Jailer Level 5)
}

-- Default blacklist (from ElvUI)
aura_env.blacklist = {
    [36900]  = Defaults(), -- Soul Split: Evil!
    [36901]  = Defaults(), -- Soul Split: Good
    [36893]  = Defaults(), -- Transporter Malfunction
    [97821]  = Defaults(), -- Void-Touched
    [36032]  = Defaults(), -- Arcane Charge
    [8733]   = Defaults(), -- Blessing of Blackfathom
    [58539]  = Defaults(), -- Watcher's Corpse
    [26013]  = Defaults(), -- Deserter
    [71041]  = Defaults(), -- Dungeon Deserter
    [41425]  = Defaults(), -- Hypothermia
    [55711]  = Defaults(), -- Weakened Heart
    [8326]   = Defaults(), -- Ghost
    [23445]  = Defaults(), -- Evil Twin
    [24755]  = Defaults(), -- Tricked or Treated
    [25163]  = Defaults(), -- Oozeling's Disgusting Aura
    [124275] = Defaults(), -- Stagger
    [124274] = Defaults(), -- Stagger
    [124273] = Defaults(), -- Stagger
    [117870] = Defaults(), -- Touch of The Titans
    [123981] = Defaults(), -- Perdition
    [15007]  = Defaults(), -- Ress Sickness
    [113942] = Defaults(), -- Demonic: Gateway
    [89140]  = Defaults(), -- Demonic Rebirth: Cooldown
    [287825] = Defaults(), -- Lethargy debuff (fight or flight)
    [325101] = Defaults(), -- Flattered (Kyrian steward thinks yoo-hoo are the best!)
    [306474] = Defaults(), -- Recharging (Mechagon ring Logic Loop proc)
    [206151] = Defaults(), -- Challenger's Burden (Mythic+)
    [396184] = Defaults(), -- Full Ruby Feasted
};


-- If ElvUI enabled, use that blacklist
local enableElvUI = not c or c.enableElvUI == true;
if ElvUI then
    
    _log("ElvUI is installed");

    if enableElvUI == true then
        _log("Using the ElvUI blacklist");
        --local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
        aura_env.blacklist = ElvDB.global.unitframe.aurafilters.Blacklist.spells;
    end
else
    _log("ElvUI not installed");
end

-- Forbearance (pally: divine shield, hand of protection, and lay on hands)
local enableForbearance = not c or c.enableForbearance < 3;
if not ElvUI or enableElvUI == false or not aura_env.blacklist[25771] or c.enableForbearance > 1 then
    aura_env.blacklist[25771]  = { enable = c.enableForbearance == 3, priority = 0, stackThreshold = 0};
end

_log("Forbearance=",aura_env.blacklist[25771].enable);

-- Lust debuffs
local enableLust = not c or c.enableLust < 3;
aura_env.blacklist[57724]  = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Sated (lust debuff)
aura_env.blacklist[57723]  = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Exhaustion (heroism debuff)
aura_env.blacklist[390435]  = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Exhaustion (Fury of the Aspects debuff)
aura_env.blacklist[80354]  = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Temporal Displacement (timewarp debuff)
aura_env.blacklist[95809]  = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Insanity debuff (hunter pet heroism: ancient hysteria)
aura_env.blacklist[264689] = { enable = not enableLust, priority = 0, stackThreshold = 0}; -- Fatigued (Primal Rage)

aura_env.refreshAuras = function(states, spellID)

    if not states then return false end

    if not WeakAuras.myGUID then 
        _log("Couldn't find player GUID");
        return false 
    end

    -- If no specific spell id (aura id) was passed, we're updating all auras.
    local updatingAllAuras = not spellID;

    local currentAuras = {};

    -- Manually find the debuff so we can get access to all properties
    local i = 1;
    while true do
        local spellName, icon, stacks, auraType, duration, expirationTime, castBy, _, _, id = UnitAura("player", i, "HARMFUL")
                
        if not spellName then break; end

        currentAuras[id] = true;

        local whitelist = aura_env.whitelist[id]

        -- Ignore blacklisted debuffs; Whitelist can override blacklist
        if aura_env.blacklist and aura_env.blacklist[id] and aura_env.blacklist[id].enable == true and (not whitelist or whitelist.enable == false) then
            _log("refreshAuras ignoring blacklisted debuff: "..spellName);
        else
            -- Are we refreshing all auras or a specific one?
            if updatingAllAuras or id == spellID then

                states[id..WeakAuras.myGUID] = {
                    changed = true,
                    show = true,
                    castBy = WA_ClassColorName(castBy),
                    name = spellName,
                    icon = icon,
                    stacks = stacks,
                    progressType = "timed",
                    expirationTime = expirationTime,
                    duration = duration,
                    spellID = id,
                    autoHide = true,
                    unit = "player",
                    unitDebuffIndex = i,
                    debuffType = auraType,
                    isDispellable = aura_env.canDispel(auraType)
                }

                -- If we're at 0 doses then we can remove
                if subEvent == "SPELL_AURA_DOSE_REMOVED" and stacks == 0 then
                    states[id..WeakAuras.myGUID].show = false
                -- If this aura has a stack threshold, then hide if it doesn't meet that threshold
                elseif whitelist and whitelist.stackThreshold > 0 and stacks < whitelist.stackThreshold then
                    states[id..WeakAuras.myGUID].show = false
                else                                
                    _log("Showing debuff: "..spellName);
                end
            end
        end
        
        i = i + 1;
    end

    -- If we're refreshing all auras, we should remove any auras that have dropped off
    if updatingAllAuras then
        --_log("Removing auras that have dropped off");
        for k,v in pairs(states) do
            if not currentAuras[v.spellID] then
                _log("Removing: "..k);
                v.changed = true
                v.show = false
            end
        end
    end
end

do

local function ProcessAllAuras(states)
    
    local batchCount = nil;
    local usePackedAura = true;

    local function HandleAura(aura)

        local displayOnlyDispellableDebuffs = false;
        local ignoreBuffs = true;
        local ignoreDebuffs = false;
        local ignoreDispelDebuffs = false;

        local type = AuraUtil.ProcessAura(aura, displayOnlyDispellableDebuffs, ignoreBuffs, ignoreDebuffs, ignoreDispelDebuffs);

        if type == AuraUtil.AuraUpdateChangedType.Debuff or type == AuraUtil.AuraUpdateChangedType.Dispel then
            UpsertAura(states, aura, type);
        end
    end
    AuraUtil.ForEachAura("player", AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful), batchCount, HandleAura, usePackedAura);
    AuraUtil.ForEachAura("player", AuraUtil.CreateFilterString(AuraUtil.AuraFilters.Harmful, AuraUtil.AuraFilters.Raid), batchCount, HandleAura, usePackedAura);
end

local function ShouldShowBuff(aura, showAll)
    if aura.isBossAura then
        return true;
    end

    if aura.isStealable then
        return true;
    end

    if aura.isFromPlayerOrPlayerPet then
        return true;
    end

    if showAll then
        return true;
    end

    return false;
end

local function UpdateAuras(states, unitAuraUpdateInfo)
    
    local aurasChanged = false;

    if unitAuraUpdateInfo == nil or unitAuraUpdateInfo.isFullUpdate then
		ProcessAllAuras(states);
		aurasChanged = true;
	else
		if unitAuraUpdateInfo.addedAuras ~= nil then
			for _, aura in ipairs(unitAuraUpdateInfo.addedAuras) do
				if ShouldShowBuff(aura, auraSettings.showAll) and not C_UnitAuras.IsAuraFilteredOutByInstanceID(unit, aura.auraInstanceID, filterString) then
                    UpsertAura(states, aura, AuraUtil.AuraFilters.Harmful, nil);
					self.auras[aura.auraInstanceID] = aura;
					aurasChanged = true;
				end
			end
		end

		if unitAuraUpdateInfo.updatedAuraInstanceIDs ~= nil then
			for _, auraInstanceID in ipairs(unitAuraUpdateInfo.updatedAuraInstanceIDs) do
				if self.auras[auraInstanceID] ~= nil then
					local newAura = C_UnitAuras.GetAuraDataByAuraInstanceID(self.unit, auraInstanceID);
					self.auras[auraInstanceID] = newAura;
					aurasChanged = true;
				end
			end
		end

		if unitAuraUpdateInfo.removedAuraInstanceIDs ~= nil then
			for _, auraInstanceID in ipairs(unitAuraUpdateInfo.removedAuraInstanceIDs) do
				if self.auras[auraInstanceID] ~= nil then
					self.auras[auraInstanceID] = nil;
					aurasChanged = true;
				end
			end
		end
	end

    return aurasChanged;
end


local function UpsertAura(states, aura, type, index)

    states[aura.auraInstanceID] = {
        changed = true,
        show = true,
        progressType = "timed",
        unit = "player",
        autoHide = true,
        unitDebuffIndex = index,
        debuffType = type,

        isDispellable = aura_env.canDispel(type),

        name = aura.name,
        icon = aura.icon,
        applications = aura.applications,
        stacks = aura.stacks,
        dispelName = aura.dispelName,
        duration = aura.duration,
        expirationTime= aura.expirationTime,
        sourceUnit= WA_ClassColorName(aura.sourceUnit),
        isStealable= aura.isStealable,
        nameplateShowPersonal= aura.nameplateShowPersonal,
        spellId= aura.spellId,
        canApplyAura= aura.canApplyAura,
        isBossAura= aura.isBossAura,
        isFromPlayerOrPlayerPet= aura.isFromPlayerOrPlayerPet,

        -- nameplateShowAll=aura.nameplateShowAll,
        -- timeMod = aura.timeMod        
    }
end

end -- do