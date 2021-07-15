--UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED

local o = aura_env.config

aura_env.captions = {
    ["FRONTAL"] = o.frontal or ">> FRONTAL ON ME <<",
    ["SLAM"] = o.slam or ">> SLAM ON ME <<",
    ["SHOCKWAVE"] = o.shockwave or ">> SHOCKWAVE ON ME <<",
    ["PURGE"] = o.purge or ">> PURGE %s! <<",
    ["SOOTHE"] = o.soothe or ">> SOOTHE %s! <<",
}

aura_env.spells = {
    ["UNIT_SPELLCAST_START"] = {

        -- De Other Side
        [333729] = { 0.9, "FRONTAL" }, -- Rise Bonesoldier: Troll Guard
        
        -- Halls of Atonement
        [322936] = { 0.91, "SLAM" },    -- Halkias: Crumbling Slam
        [326997] = { 1.4,  "FRONTAL" }, -- Stoneborn Slasher: Powerful Swipe
        [325523] = { 1.4,  "FRONTAL" }, -- Depraved Darkblade: Deadly Thrust
        
        -- Mists of Tirna Scithe
        [321968] = { 3.2, "FRONTAL" }, -- Tirnenn Villager: Bewildering Pollen
        [323137] = { 3.2, "FRONTAL" }, -- Droman Oulfarran: Bewildering Pollen
        [340300] = { 1.6, "FRONTAL" }, -- Mistveil Gorgegullet: Tongue Lashing
        
        -- Necrotic Wake
        [324323] = { 0.91, "FRONTAL" }, -- Skeletal Marauder: Gruesome Cleave
        
        -- Plaguefall
        [327233] = { 3,   "FRONTAL" }, -- Plaguebelcher: Belch Plague
        [330403] = { 2.5, "FRONTAL" }, -- Plagueroc: Wing Buffet
        [318949] = { 2.1, "FRONTAL" }, -- Blighted Spinebreaker: Festering Belch
        [321935] = { 2.2, "SLAM" },    -- Congealed Slime: Withering Filth       
        
        -- Sanguine Depths
        [320991] = { 1.8, "FRONTAL" }, -- Regal Mistdancer: Echoing Thrust
        
        -- Spires of Ascension
        [328458] = { 1.8,  "FRONTAL" },   -- Lakesis: Diminuendo
        [317985] = { 1.8,  "SHOCKWAVE" }, -- Squad Leader: Crashing Strike
        [317943] = { 0.91, "FRONTAL" },   -- Forsworn Vanguard: Sweeping Blow
        [324205] = { 2.7,  "FRONTAL" },   -- Ventunax: Blinding Flash
        [324608] = { 1.4,  "SLAM" },      -- Oryphrion: Charged Stomp

        -- Castle Nathria
        [326455] = { 1.5, "FRONTAL"}, -- Sun King's Salvation: Fiery Strike
        [329181] = { 3,   "FRONTAL"}, -- Sire Denathrius: Wracking Pain

        -- Tazavesh
        [356404] = { 2,   "FRONTAL"}, -- Ancient Core Hound: Lava Breath
        [350919] = { 1,   "FRONTAL"}, -- Myza's Oasis: Crowd Control
        [357542] = { 2.5, "FRONTAL"}, -- Myza's Oasis: Rip Cord
        [346116] = { 2.6, "FRONTAL"}, -- Hylbrande: Shearing Swings
        [347094] = { 2,   "FRONTAL"}, -- Hylbrande: Titanic Crash
        [347149] = { 1.5, "FRONTAL"}, -- Timecap'n Hooktail: Infinite Breath

        -- Sanctum of Domination
        [349890] = { 2.0, "FRONTAL"}, -- Remnant of Ner'zhul: Suffering
        [358205] = { 1.5, "FRONTAL"}, -- Screamspike (Trash): Incinerating Cleave
    },
    
    ["UNIT_SPELLCAST_SUCCEEDED"] = {
        
        -- De Other Side
        [333227] = { 0.9, "SOOTHE" }, -- Risen Warlord: Undying Rage

        -- Spires of Ascension
        [327332] = { 1.5, "PURGE" }, -- Forsworn Mender: Imbue Weapon
        [327655] = { 1.5, "PURGE" }, -- Forsworn Champion: Infuse Weapon
        [328288] = { 1.5, "PURGE" }, -- Forsworn Warden: Bless Weapon
        
        -- Theatre of Pain
        [333241] = { 0.4, "SOOTHE" }, -- Raging Bloodhorn: Raging Tantrum
    },
}