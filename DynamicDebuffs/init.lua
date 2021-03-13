local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

aura_env.blacklist = ElvDB.global.unitframe.aurafilters.Blacklist.spells;

aura_env.convert = {
    ["BUFF"] = "HELPFUL",
    ["DEBUFF"] = "HARMFUL",
}
--to convert auraType (BUFF/DEBUFF) from CLEU payload

aura_env.sound = {
    [1] = "Interface\\AddOns\\SharedMedia_Causese\\sound\\Taunt.ogg",
    [2] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Taunt.ogg",
    [3] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RingingPhone.ogg",
    [4] = "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\AirHorn.ogg",
}
-- bully rivers doesn't want to add sound option to custom options

aura_env.associatedDebuff = {
    [307476] = 307472,
    [307478] = 307471,
}

--[[
debuff that's associated with a certain cast
left the cast's spellID that causes the debuff
right the spellID of opposite cast's applied debuff
this is used for tank-combo-cast mechanics such as grong/aggramar]]

