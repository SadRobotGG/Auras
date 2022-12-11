--Events: UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED
-- Zone filters: g433,g430,g428,2093,g252,g240,g223,g201,g437,731,g245
local o = aura_env.config

aura_env.captions = {
    ["FRONTAL"] = o.frontal or ">> %2$s on %3$s <<",
    ["SLAM"] = o.slam or ">> %2$s on %3$s <<",
    ["SHOCKWAVE"] = o.shockwave or ">> %2$s on %3$s <<",
    ["PURGE"] = o.purge or ">> PURGE %s! <<",
    ["SOOTHE"] = o.soothe or ">> SOOTHE %s! <<",
    ["SOOTHE_SPELL"] = o.sootheSpell or ">> SOOTHE %2$s! <<",
    ["SPELL_TARGET"] = o.spellTarget or ">> %2$s on %3$s <<"
}

local function Defaults(id, duration, type, caption)

    local options = o["spell"..id]

    local enabled = options == nil or options == true;

    local name = GetSpellInfo(id)

    return {
        id = id,
        duration = duration or 1.0,
        type = type or "FRONTAL",
        enabled = enabled,
        name = name,
        caption = caption
    }
end

aura_env.spells = {
    ["UNIT_SPELLCAST_START"] =
    {
        -- Algeth'ar Academy g433
        [388976] = Defaults( 388976, 1, "SHOCKWAVE" ), -- Arcane Ravager: Riftbreath
        [385958] = Defaults( 385958),               -- Vexamus: Arcane Explusion
        [377383] = Defaults( 377383, 1, "SHOCKWAVE"),  -- Alpha Eagle: Gust
        [377034] = Defaults( 377034, 1, "SHOCKWAVE"),  -- Crawth: Overpowering Gust
        [374361] = Defaults( 374361, 1, "SHOCKWAVE"),  -- Echo of Doragosa: Astral Break

        -- The Azure Vault g428
        [386660] = Defaults( 386660, 1, "SHOCKWAVE"),  -- Leymor: Erupting Fissure
        [370764] = Defaults( 370764),               -- Crystal Fury: Piercing Shards
        [387067] = Defaults( 387067),               -- Arcane Construct: Arcane Bash
        [391118] = Defaults( 391118),               -- Scalebane Lieutenant: Spellfrost Breath
        [372222] = Defaults( 372222),               -- Azureblade: Arcane Cleave
        [384699] = Defaults( 384699),               -- Umbrelskul: Crystalline Roar

        -- Court of Stars g252
        [207979] = Defaults(207979, 1.5, "SHOCKWAVE"), -- Jazshariu: Shockwave
        [214688] = Defaults(214688, 2.5, "SHOCKWAVE"), -- Gerenth the Vile (Suspicious Noble): Carrion Swarm

        -- Halls of Valor g240
        [198888] = Defaults( 198888),               -- Storm Drake: Lightning Breath
        [193083] = Defaults( 193083),               -- Hymdall: Bloodletting Sweep
        [199050] = Defaults( 199050),               -- Valarjar Shieldmaiden: Mortal Hew

        -- The Nokhud Offensive 2093
        [382233] = Defaults( 382233, 1, "SHOCKWAVE"), -- Batak: Broad Stomp

        -- Ruby Life Pools g430

        -- Shadowmoon Burial Grounds g223
        [153395] = Defaults( 153395),               -- Carrion Worm: Body Slam
        [153686] = Defaults( 153686),               -- Bonemaw: Body Slam
        [154175] = Defaults( 154175),               -- Bonemaw: Body Slam
        [154442] = Defaults( 154442),               -- Ner'zhul: Malevolence

        -- Temple of the Jade Serpent g201

        -- TIMEWALKING

        -- Neltharion's Lair 731
        [188169] = Defaults(188169, 3, "FRONTAL"), -- Rokmora: Razor Shards

        -- Black Rook Hold g245
        [200261] = Defaults(200261, 2.3, "SHOCKWAVE") -- Soul-Torn Champion: Bonebreaking Strike
    },

    ["UNIT_SPELLCAST_SUCCEEDED"] = {
    },
}