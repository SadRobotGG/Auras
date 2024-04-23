--Events: UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED
-- Zone filters: g182,g236,g245,g275,g279,g440,733
-- Zone filters: g429,g430,g431,g432,g433,g434,428,2093,g252,g240,g223,g201,g437,731,g245,936,g438,g282,325
local o = aura_env.config

aura_env.captions = {
    ["FRONTAL"] = o.frontal or ">> FRONTAL ON ME <<",
    ["SLAM"] = o.slam or ">> SLAM ON ME <<",
    ["SHOCKWAVE"] = o.shockwave or ">> SHOCKWAVE ON ME <<",
    ["KNOCKBACK"] = o.knockback or ">> KNOCKBACK ON ME <<",
    ["PURGE"] = o.purge or ">> PURGE %s! <<",
    ["SOOTHE"] = o.soothe or ">> SOOTHE %s! <<",
    ["SOOTHE_SPELL"] = o.sootheSpell or ">> SOOTHE %2$s! <<",
    ["PURGE_SPELL"] = o.purgeSpell or ">> PURGE %2$s! <<",
    ["SPELL_TARGET"] = o.spellTarget or ">> %2$s on %3$s <<",
    ["STACK"] = o.stack or ">> STACK FOR %2$s <<",
}

local function Defaults(id, type, ignoreTarget)

    local options = o["spell"..id]

    local enabled = options == nil or options == true;

    local name = GetSpellInfo(id)

    return {
        id = id,
        duration = 2,
        type = type,
        enabled = enabled,
        name = name,
        ignoreTarget = ignoreTarget
    }
end

aura_env.spells = {
    ["UNIT_SPELLCAST_START"] =
    {
        -- SEASON FOUR

        -- Algeth'ar Academy g433
        [388976] = Defaults(388976, "SHOCKWAVE", true), -- Arcane Ravager: Riftbreath
        [385958] = Defaults(385958),                    -- Vexamus: Arcane Explusion
        --[377383] = Defaults(377383, "SHOCKWAVE"),     -- Alpha Eagle: Gust; Random
        --[377034] = Defaults(377034, "SHOCKWAVE"),     -- Crawth: Overpowering Gust; Random
        --[374361] = Defaults(374361, "SHOCKWAVE"),     -- Echo of Doragosa: Astral Breath; Random

        -- The Azure Vault g428
        [386660] = Defaults(386660, "SHOCKWAVE"),  -- Leymor: Erupting Fissure
        [370764] = Defaults(370764),               -- Crystal Fury: Piercing Shards
        [387067] = Defaults(387067, "KNOCKBACK"),  -- Arcane Construct: Arcane Bash
        [391118] = Defaults(391118),               -- Scalebane Lieutenant: Spellfrost Breath
        [372222] = Defaults(372222),               -- Azureblade: Arcane Cleave
        --[384699] = Defaults( 384699),            -- Umbrelskul: Crystalline Roar

        -- Brackenhide Hollow g432
        --[382712] = Defaults(382712),              -- Wilted Oak: Necrotic Breath
        [376231] = Defaults(376231, "SHOCKWAVE"), -- Treemouth: Decay Spray
        [377559] = Defaults(377559, "KNOCKBACK"), -- Treemouth: Vine Whip
        [376170] = Defaults(376170, "SHOCKWAVE"), -- Decatriarch Wratheye: Choking Rotcloud

        -- Halls of Infusion g434
        [384524] = Defaults(384524, "SHOCKWAVE"), -- Watcher Irideus: Titanic Fist
        [374563] = Defaults(374563, "SHOCKWAVE"), -- Dazzling Dragonfly: Dazzle
        [375351] = Defaults(375348), -- Gusting Proto-Dragon: Gusting Breath - can out-range 10yd
        [375351] = Defaults(375351), -- Glacial Proto-Dragon: Oceanic Breath
        [375327] = Defaults(375327), -- Subterranean Proto-Dragon: Tectonic Breath
        [393432] = Defaults(393432), -- Refti Defender: Spear Flurry

        -- Neltharus g431
        [397010] = Defaults(397010, "SHOCKWAVE"), --  Qalashi Warden: Volcanic Guard
        [382708] = Defaults(382708, "SHOCKWAVE"), --  Qalashi Warden: Volcanic Guard
        [372311] = Defaults(372311), -- Qalashi Trainee: Magma Fist
        [395184] = Defaults(395184), -- Qalashi Irontorch: Scorching Breath

        -- The Nokhud Offensive 2093
        [387135] = Defaults(387135),               -- Primalist Arcblade: Arcing Strike
        [387629] = Defaults(387629, "SHOCKWAVE"),  -- Desecrated Ohuna: Rotting Wind
        [382233] = Defaults(382233, "SHOCKWAVE"),  -- Batak: Broad Stomp

        -- Ruby Life Pools g430
        [392395] = Defaults(392395, "KNOCKBACK"),  -- Thunderhead: Thunder Jaw

        -- Uldaman g429
        [369409] = Defaults(369409), -- Earthen Custodian: Cleave
        [369563] = Defaults(369563), -- Baelog: Wild Cleave
        [369061] = Defaults(369061), -- Emberon: Searing Clap
        [375727] = Defaults(375727), -- Chrono-Lord Deios: Sand Breath

        -- SEASON THREE

        -- g182,g236,g245,g275,g279,g440,733

        -- Atal'Dazar (Battle for Azeroth) g275 Icon: 2011105
        [255567] = Defaults(255567), -- -- T'lonja 128455 Frenzied Charge

        -- Black Rook Hold (Legion) g245 Icon: 1417423
        [200261] = Defaults(200261, "SHOCKWAVE"), -- Soul-Torn Champion 98243, Commander Shemdah'sohn 98706: Bonebreaking Strike
        [197974] = Defaults(197974, "SHOCKWAVE"), -- Soul-torn Vanguard 100485: 197974 Bonecrushing Strike
        [225732] = Defaults(225732, "FRONTAL"), -- Lady Velandras Ravencrest 98538: 225732 Strike Down
        -- Risen Archer 98275
        -- Wyrmtongue Scavenger 98792

        -- Darkheart Thicket (Legion) 733, Icon: 1417425
        [200768] = Defaults(200768, "SHOCKWAVE"), -- Crazed Razorbeak 95766: Propelling Charge
        [201226] = Defaults(201226, "SHOCKWAVE"), -- Bloodtainted Fury 100531: Blood Assault
        [204667] = Defaults(204667), -- Oakheart 103344: Nightmare Breath
        [191326] = Defaults(191326, "SHOCKWAVE"), -- Dresaron 99200: Breath of Corruption

        -- Dawn of the Infinites g440, Icon: 5247561
        [413529] = Defaults(413529), -- Timestream Anomaly 199749: Untwist
        [407159] = Defaults(407159), -- Blight of Galakrond 198997 Blight Reclamation 407159
        [412129] = Defaults(412129, "SHOCKWAVE"), -- Lerai, Timesworn Maiden 205152 Orb of Contemplation
        [408141] = Defaults(408141), -- Dazhak 201788 Incinerating Blightbreath
        --[401482] = Defaults(401482), -- Tyr, the Infinite Keeper 198998: Infinite Annihilation
        [401248] = Defaults(401248, "KNOCKBACK"), -- Tyr, the Infinite Keeper 198998 Titanic Blow 401248
        [400641] = Defaults(400641, "STACK"), -- Tyr, the Infinite Keeper 198998 Dividing Strike 400641
        [404916] = Defaults(404916), -- Morchie: Sand Blast
        [412505] = Defaults(412505), -- Tyr's Vanguard 205151 Rending Cleave 412505
        [419351] = Defaults(419351), -- Infinite Saboteur 208438: Bronze Exhalation 419351
        [416139] = Defaults(416139), -- Chrono-Lord Deios 199000: Temporal Breath 416139
        [418056] = Defaults(418056, "SHOCKWAVE"), -- Anduin Lothar 203679 Shockwave 418056
        
        -- Everbloom (Warlords of Draenor) g236, Icon: 967517
        [169714] = Defaults(169714), -- Gnarlroot 81984: Gasp 169714
        [164357] = Defaults(164357), -- Witherbark 81522: Parched Gasp 164357
        [427510] = Defaults(427510, "SLAM"), -- Dulhu 83894: Noxious Charge 427510
        [427512] = Defaults(427512, "SLAM"), -- Dulhu 83894: Noxious Charge 427512
        [169179] = Defaults(169179, "SHOCKWAVE"), -- Yalnu: Colossal Blow 169179
        [169929] = Defaults(169929, "SHOCKWAVE"), -- Gnarled Ancient 84400: Lumbering Swipe 169929

        -- Throne of the Tides (Cataclysm) g182, Icon: 409600
        [426645] = Defaults(426645), -- Naz'jar Ravager 212673: Acid Barrage 426645
        [428293] = Defaults(428293, "SHOCKWAVE"), -- Naz'jar Honor Guard 40633: Trident Flurry 428293
        [428530] = Defaults(428530), -- Ink of Ozumat 213770: Murk Spew 428530

        -- Waycrest Manor (Battle for Azeroth) g279, Icon: 2011154
        [271174] = Defaults(271174, "SHOCKWAVE"), -- Pallid Gorger 137830: Retch
        [265372] = Defaults(265372, "SHOCKWAVE"), -- Bewitched Captain 131587: Shadow Cleave

        -- RAIDS

        -- Aberrus g438
        [406783] = Defaults(406783),              -- Amalgamation Chamber: Shadowflame Burst
        [401258] = Defaults(401258),              -- Assault of the Zaqali: Heavy Cudgel
        [410351] = Defaults(410351),              -- Assault of the Zaqali: Flaming Cudgel
        [401022] = Defaults(401022, "KNOCKBACK"), -- Echo of Neltharion: Calamitous Strike
        [408422] = Defaults(408422),              -- Scalecommader Sarkareth: Void Slash
        [408425] = Defaults(408425),              -- Scalecommader Sarkareth: Void Slash

        -- Vault of the Incarnates g437

        --[370615] = Defaults(370615) -- Eranog: Molten Cleave; Random
        [376279] = Defaults(376279), -- Terros: Concussive Slam
        [374112] = Defaults(374112), -- Sennarth's Frostbreath Arachnid: Freezing Breath
        [390548] = Defaults(390548), -- Kurog Grimtotem: Sundering Strike
        [386410] = Defaults(386410), -- Raszageth: Thunderous Blast

        -- Amirdrassil g279, Icon: 2011154
        [417431] = Defaults(417431), -- Fyrakk 137830: Fyr'alath's Bite
    },

    ["UNIT_SPELLCAST_SUCCEEDED"] = {

        -- SEASON 4

        -- Algethar Academy
        [390938] = Defaults(390938, "SOOTHE", true), -- Aggravated Skitterfly: Agitation
        [387955] = Defaults(387955, "PURGE", true), -- Ethereal Restorer: Celestial Shield
        [377389] = Defaults(377389, "SOOTHE_SPELL", true), -- Alpha Eagle: Call of the Flock

        -- Azure Vault
        [389686] = Defaults(389686, "SOOTHE", true), -- Crystal Fury: Arcane Fury

        -- Brackenhide Hollow
        [382555] = Defaults(382555, "SOOTHE"), -- Bracken Warscourge: Ragestorm
        
        -- Nokhud Offensive
        [386223] = Defaults(386223, "PURGE", true), -- Primal Stormshield: Stormshield

        -- Ruby Life Pools
        [372749] = Defaults(372749, "PURGE", true), -- Flashfrost Chillweaver: Ice Shield
        [373972] = Defaults(373972, "PURGE", true), -- Primalist Flamedancer: Blaze of Glory
        [392454] = Defaults(392454, "PURGE", true), -- Flame Channeler: Burning Veins; might not want to purge as it damages themselves
        [385063] = Defaults(385063, "PURGE", true), -- Primalist Cinderweaver: Burning Ambition; increases damage taken so don't purge

        -- SEASON 3

        -- Atal'Dazar
        [255579] = Defaults(255579, "PURGE", true),  -- Priestess Alun'za 122967: Gilded Claws

        -- Throne of the Tides
        [426618] = Defaults(426618, "SOOTHE", true), -- Naz'jar Invader 40584: Slithering Assault
        [428329] = Defaults(428329, "PURGE", true),  -- Naz'jar Frost Witch 44404: Icy Veins

        -- Waycrest Manor
        [265368] = Defaults(265368, "PURGE", true), -- Bewitched Captain 131587: Spirited Defense 265368
    },
}