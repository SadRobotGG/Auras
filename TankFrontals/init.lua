--Events: UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED

local o = aura_env.config

aura_env.captions = {
    ["FRONTAL"] = o.frontal or ">> FRONTAL ON ME <<",
    ["SLAM"] = o.slam or ">> SLAM ON ME <<",
    ["SHOCKWAVE"] = o.shockwave or ">> SHOCKWAVE ON ME <<",
    ["PURGE"] = o.purge or ">> PURGE %s! <<",
    ["SOOTHE"] = o.soothe or ">> SOOTHE %s! <<",
    ["SOOTHE_SPELL"] = o.sootheSpell or ">> SOOTHE %2$s! <<",
}

local function Defaults(id, duration, type, caption)

    local options = o["spell"..id]

    local enabled = options == nil or options == true;

    local name = GetSpellInfo(id)

    return {
        id = id,
        duration = duration,
        type = type,
        enabled = enabled,
        name = name,
        caption = caption
    }
end

aura_env.spells = {
    ["UNIT_SPELLCAST_START"] = {
        
        -- Grimrail Depot g225
        [161090] = Defaults( 161090, 3.0, "FRONTAL" ),   -- Borka: Mad Dash
        [166675] = Defaults( 166675, 1.0, "SHOCKWAVE" ), -- Grom'kar Gunner: Shrapnel Blast
        [166380] = Defaults( 160943, 1.0, "SHOCKWAVE" ), -- Grom'kar Captain: Reckless Slash
        [164163] = Defaults( 164163, 3.0, "FRONTAL"),    -- Grimrail Overseer: Hewing Swipe
        
        -- Iron Docks 595
        [172982] = Defaults( 172982, 1.5, "SLAM" ),      -- Siegmaster Olugar / Siegemaster Rokra: Shattering Strike
        
        [163665] = Defaults( 163665, 1.0, "FRONTAL" ),   -- Makogg Emberblade: Flaming Slash
        [167815] = Defaults( 167815, 1.0, "FRONTAL" ),   -- Thunderlord Wrangler: Rending Cleave
        [167815] = Defaults( 173307, 1.2, "SHOCKWAVE" ), -- Thunderlord Wrangler: Serrated Spear
        [173514] = Defaults( 173514, 1.0, "SHOCKWAVE" ), -- Ironwing Flamespitter: Lava Blast
                
        -- Operation Mechagon: Junkyard g399
        [298940] = Defaults( 298940, 2.5, "SHOCKWAVE" ), -- Naeno: Bolt Buster
        
        -- Operation Mechagon: Workshop g399
        [294290] = Defaults( 294290, 2.5,  "FRONTAL" ), -- Waste Processing Unit: Process Waste

        -- Return to Karazhan: Lower g260
        [241774] = Defaults( 241774, 2.0, "SLAM" ),    -- Phantom Guardsman: Shield Smash
        [228637] = Defaults( 228637, 2.0, "SLAM" ),    -- Spectral Journeyman: Smash
        [227493] = Defaults( 227493, 1.5, "FRONTAL" ), -- Attumen: Mortal Strike
        [228852] = Defaults( 228852, 3.8, "SLAM" ),    -- Attumen: Shared Suffering
        [29665] = Defaults( 29665, 2.0, "FRONTAL" ),   -- Ghostly Chef: Cleave

        -- Return to Karazhan: Upper g260
        [229622] = Defaults( 229622, 2.0, "FRONTAL" ), -- Fel Bat: Fel Breath
        [230044] = Defaults( 230044, 0.5, "FRONTAL" ), -- Wrathguard Flamebringer: Cleave
        [229608] = Defaults( 229608, 1.5, "FRONTAL" ), -- Erudite Slayer: Mighty Swing
        [229611] = Defaults( 229611, 1.5, "SLAM" ),    -- Erudite Slayer: Heavy Smash       
                
        -- Tazavesh: Streets g4062727
        [356404] = Defaults(356404, 2,   "FRONTAL" ), -- Ancient Core Hound: Lava Breath
        [357542] = Defaults(357542, 2.5, "FRONTAL" ), -- Myza's Oasis: Rip Cord

        -- Tazavesh: Gambit g4062727
        [347094] = Defaults(347094, 2,   "FRONTAL" ), -- Hylbrande: Titanic Crash

        -- Sanctum of Domination g4062765
        [349890] = Defaults(349890, 2.0, "FRONTAL" ), -- Remnant of Ner'zhul: Suffering
        [358205] = Defaults(358205, 1.5, "FRONTAL" ), -- Screamspike (Trash): Incinerating Cleave
        
        -- Sepulcher of the First Ones g4254074
        [361689] = Defaults(361689, 1.2, "FRONTAL"), -- Prototype of Absolution: Wracking Pain
        
        -- Castle Nathria g3614361
        [326455] = Defaults(326455, 1.5, "FRONTAL" ), -- Sun King's Salvation: Fiery Strike
        [329181] = Defaults(329181, 3,   "FRONTAL" ), -- Sire Denathrius: Wracking Pain

        -- Court of Stars g252
        [207979] = Defaults(207979, 1.5, "SHOCKWAVE"), -- Jazshariu: Shockwave
        [214688] = Defaults(214688, 2.5, "SHOCKWAVE"), -- Gerenth the Vile (Suspicious Noble): Carrion Swarm

        -- Neltharion's Lair 731
        [188169] = Defaults(188169, 3, "FRONTAL"), -- Rokmora: Razor Shards

        -- Black Rook Hold g245
        [200261] = Defaults(200261, 2.3, "SHOCKWAVE") -- Soul-Torn Champion: Bonebreaking Strike
    },
    
    ["UNIT_SPELLCAST_SUCCEEDED"] = {
        -- Tazavesh: Streets
        [355782] = Defaults(355782, 1.0, "PURGE" ),  -- Commerce Enforcer: Force Multiplier
        [349934] = Defaults(349934, 0.76, "PURGE" ), -- Menagerie: Flagellation Protocol
        [356549] = Defaults(356549, 0.76, "PURGE" ), -- Support Officer: Refraction Shield
        [355888] = Defaults(355888, 0.79, "PURGE" ), -- Customs Security: Hard Light Baton

        -- Grimrail Depot
        [166335] = Defaults( 166335, 2.5, "PURGE" ), -- Grom'kar Far Seer: Stormshield

        -- Iron Docks
        [162350] = Defaults( 162350, 1.0, "FRONTAL" ),   -- Oshir: Primal Assault
        [169073] = Defaults( 169073, 2.5, "SHOCKWAVE" ), -- Koramar: Shattering Blade
        [164730] = Defaults( 164730, 1.5, "FRONTAL" ), -- Dreadfang: Shredding Swipes
    },
}
