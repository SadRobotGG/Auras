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

-- If we're not using ElvUI, we can use their default blacklist instead
local function Defaults(priorityOverride)
	return {
		enable = true,
		priority = priorityOverride or 0,
		stackThreshold = 0
	}
end

aura_env.blacklist = {
    [36900]  = Defaults(), -- Soul Split: Evil!
    [36901]  = Defaults(), -- Soul Split: Good
    [36893]  = Defaults(), -- Transporter Malfunction
    [97821]  = Defaults(), -- Void-Touched
    [36032]  = Defaults(), -- Arcane Charge
    [8733]   = Defaults(), -- Blessing of Blackfathom
    --[25771]  = Defaults(), -- Forbearance (pally: divine shield, hand of protection, and lay on hands)
    [57724]  = Defaults(), -- Sated (lust debuff)
    [57723]  = Defaults(), -- Exhaustion (heroism debuff)
    [80354]  = Defaults(), -- Temporal Displacement (timewarp debuff)
    [95809]  = Defaults(), -- Insanity debuff (hunter pet heroism: ancient hysteria)
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
};

-- If we don't use ElvUI, then just stick to the defaults.
if not ElvUI then return true end

local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

aura_env.blacklist = ElvDB.global.unitframe.aurafilters.Blacklist.spells;