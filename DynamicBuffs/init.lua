local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

aura_env.blacklist = ElvDB.global.unitframe.aurafilters.Blacklist.spells;

aura_env.convert = {
    ["BUFF"] = "HELPFUL",
    ["DEBUFF"] = "HARMFUL",
}