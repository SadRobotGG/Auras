-- Custom options
local c = aura_env.config;

local _log = function(...)
    if aura_env and aura_env.config and aura_env.config.enableDebug == true then
        print(...);
    end
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