--Events: UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED
-- Zone filters: g433,g430,g428,2093,g252,g240,g223,g201,g437,731,g245
local o = aura_env.config

aura_env.captions = {
    ["FRONTAL"] = o.frontal or ">> FRONTAL ON ME <<",
    ["SLAM"] = o.slam or ">> SLAM ON ME <<",
    ["SHOCKWAVE"] = o.shockwave or ">> SHOCKWAVE ON ME <<",
    ["KNOCKBACK"] = o.knockback or ">> KNOCKBACK ON ME <<",
    ["PURGE"] = o.purge or ">> PURGE %s! <<",
    ["SOOTHE"] = o.soothe or ">> SOOTHE %s! <<",
    ["SOOTHE_SPELL"] = o.sootheSpell or ">> SOOTHE %2$s! <<",
    ["SPELL_TARGET"] = o.spellTarget or ">> %2$s on %3$s <<"
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
        -- Algeth'ar Academy g433
        [388976] = Defaults(388976, "SHOCKWAVE", true), -- Arcane Ravager: Riftbreath
        [385958] = Defaults(385958),               -- Vexamus: Arcane Explusion
        --[377383] = Defaults(377383, "SHOCKWAVE"),  -- Alpha Eagle: Gust; Random
        --[377034] = Defaults(377034, "SHOCKWAVE"),  -- Crawth: Overpowering Gust; Random
        --[374361] = Defaults(374361, "SHOCKWAVE"),  -- Echo of Doragosa: Astral Breath; Random

        -- The Azure Vault g428
        [386660] = Defaults(386660, "SHOCKWAVE"),  -- Leymor: Erupting Fissure
        [370764] = Defaults(370764),               -- Crystal Fury: Piercing Shards
        [387067] = Defaults(387067, "KNOCKBACK"),  -- Arcane Construct: Arcane Bash
        [391118] = Defaults(391118),               -- Scalebane Lieutenant: Spellfrost Breath
        [372222] = Defaults(372222),               -- Azureblade: Arcane Cleave
        --[384699] = Defaults( 384699),               -- Umbrelskul: Crystalline Roar

        -- Court of Stars g252
        [209027] = Defaults(209027), -- Duskwatch Guard: Quelling Strike
        [209495] = Defaults(209495), -- Guardian Construct: Charged Smash
        [207979] = Defaults(207979, "SHOCKWAVE"), -- Jazshariu: Shockwave

        -- Halls of Valor g240
        [198888] = Defaults(198888),               -- Storm Drake: Lightning Breath
        [193083] = Defaults(193083),               -- Hymdall: Bloodletting Sweep
        [199050] = Defaults(199050),               -- Valarjar Shieldmaiden: Mortal Hew
        [191508] = Defaults(191508, "SHOCKWAVE"),  -- Valarjar Aspirant: Blast of Light

        -- The Nokhud Offensive 2093
        [384510] = Defaults(384510),               -- Nokhud Lancemaster: Cleaving Strikes
        [387135] = Defaults(387135),               -- Primalist Arcblade: Arcing Strike
        [387629] = Defaults(387629, "SHOCKWAVE"),  -- Desecrated Ohuna: Rotting Wind
        [382233] = Defaults(382233, "SHOCKWAVE"),  -- Batak: Broad Stomp

        -- Ruby Life Pools g430
        [392395] = Defaults(392395, "KNOCKBACK"),  -- Thunderhead: Thunder Jaw

        -- Shadowmoon Burial Grounds g223
        [153395] = Defaults(153395, "SHOCKWAVE"),  -- Carrion Worm: Body Slam
        --[153686] = Defaults(153395),             -- Bonemaw: Body Slam
        [154175] = Defaults(154175, "SHOCKWAVE"),  -- Bonemaw: Body Slam
        --[154442] = Defaults(154442),               -- Ner'zhul: Malevolence
        [152792] = Defaults(152792),               -- Nhallish: Void Blast

        -- Temple of the Jade Serpent g201
        [114646] = Defaults(114646),               -- Haunting Sha: Haunting Gaze
        [396907] = Defaults(396907, "SHOCKWAVE"),  -- Yu'lon: Jade Fire Breath

        -- TIMEWALKING

        -- Neltharion's Lair 731
        [188169] = Defaults(188169), -- Rokmora: Razor Shards

        -- Black Rook Hold g245
        [200261] = Defaults(200261, "SHOCKWAVE"), -- Soul-Torn Champion: Bonebreaking Strike

        -- RAIDS

        -- Vault of the Incarnates g437

        --[370615] = Defaults(370615) -- Eranog: Molten Cleave; Random
        [374112] = Defaults(374112), -- Sennarth's Frostbreath Arachnid: Freezing Breath
        [390548] = Defaults(390548), -- Kurog Grimtotem: Sundering Strike
        [386410] = Defaults(386410), -- Raszageth: Thunderous Blast
    },

    ["UNIT_SPELLCAST_SUCCEEDED"] = {
        [188169] = Defaults(188169, "FRONTAL"), -- Rokmora: Razor Shards

        -- Algethar Academy
        [390938] = Defaults(390938, "SOOTHE", true), -- Aggravated Skitterfly: Agitation
        [387955] = Defaults(387955, "PURGE", true), -- Ethereal Restorer: Celestial Shield
        [377389] = Defaults(377389, "SOOTHE_SPELL", true), -- Alpha Eagle: Call of the Flock

        -- Court of Stars
        [209033] = Defaults(209033, "PURGE", true), -- Duskwatch Guard: Fortification
        --[225100] = Defaults(225100, "PURGE", true), -- Guardian Construct: Charging Station; Can't be dispelled?

        -- Halls of Valor
        [198745] = Defaults(198745, "PURGE", true), -- Stormforged Sentinel: Protective Light

        -- Nokhud Offensive
        [386223] = Defaults(386223, "PURGE", true), -- Primal Stormshield: Stormshield

        -- Ruby Life Pools
        [372749] = Defaults(372749, "PURGE", true), -- Flashfrost Chillweaver: Ice Shield
        [392454] = Defaults(392454, "PURGE", true), -- Flame Channeler: Burning Veins; might not want to purge as it damages themselves

        -- Shadowmoon Burial Grounds
        [398151] = Defaults(398151, "PURGE", true), -- Shadowmoon Loyalist: Sinister Focus

        -- Temple of the Jade Serpent
        [396018] = Defaults(396018, "SOOTHE", true), --The Crybaby Hozen: Fit of Rage
    },
}