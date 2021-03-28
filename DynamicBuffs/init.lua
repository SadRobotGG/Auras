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

aura_env.whitelist = {
    [332514] = { enable = true, priority = 0, stackThreshold = 80}, -- Bron (show at 80 stacks)
}

-- If we don't use ElvUI, then just stick to the defaults.
if not ElvUI then return true end

local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

aura_env.blacklist = ElvDB.global.unitframe.aurafilters.Blacklist.spells;