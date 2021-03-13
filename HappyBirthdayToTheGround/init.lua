local c = aura_env.config

aura_env.spells = {
    ["SPELL_CAST_START"] = {
        -- Warlock:
        [152108] = { 2, "|cffff5108" }, -- Cataclysm
        [30283] = { 2, "|cffff00e1" }, -- Shadowfury
    },
    ["SPELL_CAST_SUCCESS"] = {
        -- Death Knight:
        [43265] = { 10, "|cffff0000" }, -- Death and Decay
        [324128] = { 10, "|cff255cf9" }, -- Death's Due
        -- Demon Hunter:
        [342817] = { 3, "|cff00e932" }, -- Glaive Tempest
        -- Druid:
        [205636] = { 10, "|cffd700ff" }, -- Force of Nature
        [78675] = { 8, "|cffffe800" }, -- Solar Beam
        [191034] = { 8, "|cff59f7ff" }, -- Starfall
        [102793] = { 10, "|cff009eff" }, -- Ursol's Vortex
        -- Hunter:
        [109248] = { 10, "|cff006cff" }, -- Binding Shot
        [308491] = { 10, "|cff88dbff" }, -- Resonating Arrow
        [187698] = { 30, "|cffc8c8c8" }, -- Tar Trap
        [260243] = { 6, "|cffcf3656" }, -- Volley
        [328231] = { 15, "|cff255cf9" }, -- Wild Spirits
        -- Mage:
        [153626] = { 3, "|cffdb5cff" }, -- Arcane Orb
        [190356] = { 8, "|cff0083ff" }, -- Blizzard
        [2120] = { 8, "|cffff7d00" }, -- Flamestrike
        [84714] = { 15, "|cff00dcff" }, -- Frozen Orb
        [153561] = { 12, "|cffff0000" }, -- Meteor
        [113724] = { 10, "|cff00e1ff" }, -- Ring of Frost
        -- Monk:
        [116844] = { 5, "|cff00ff8c" }, -- Ring of Peace
        -- Paladin:
        [316958] = { 30, "|cff600000" }, -- Ashen Hallow
        [26573] = { 12, "|cffffa34d" }, -- Consecration
        -- Shaman:
        [325886] = { 12, "|cff255cf9" }, -- Ancient Aftershock
        [198103] = { 60, "|cffd56100" }, -- Earth Elemental
        [2484] = { 20, "|cffe1a5ff" }, -- Earthbind Totem
        [61882] = { 6, "|cffff7d00" }, -- Earthquake
        [192222] = { 15, "|cffff0000" }, -- Liquid Magma Totem
        [8143] = { 10, "|cffffd122" }, -- Tremor Totem
        [324386] = { 30, "|cff88dbff" }, -- Vesper Totem
        [192077] = { 15, "|cff00ff00" }, -- Wind Rush Totem
        -- Warlock:
        [267211] = { 6, "|cff4bff00" }, -- Bilescourge Bombers
        [5740] = { 8, "|cffff0000" }, -- Rain of Fire
        -- Warrior:
        [152277] = { 7, "|cffd2442d" }, -- Ravager
    }
}

