--Events: UNIT_SPELLCAST_START UNIT_SPELLCAST_SUCCEEDED PLAYER_REGEN_ENABLED
-- Zone filters Season 1: g450,g448,2359,2341,293,1669,g410,1162
-- Zone filters TWW Dungeons: g446,2341
-- Zone filters: g450,g448,2359,2341,293,1669,g410,1162,g446,2341
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

    local name = C_Spell.GetSpellInfo(id)

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
        -- SEASON ONE
        -- g450,g448,2359,2341,293,1669,g410,1162

        -- Ara-Kara, City of Echoes g450
        [433443] = Defaults(433443, "SHOCKWAVE"), -- Anubzekt: Impale
        [435012] = Defaults(435012, "SHOCKWAVE"), -- Anubzekt: Impale
        [453161] = Defaults(453161, "SHOCKWAVE"), -- Hulking Bloodguard: Impale
        [434824] = Defaults(434824), -- Atik: Web Spray

        -- City of Threads g448
        [439621] = Defaults(439621, "SHOCKWAVE"), -- Nx: Shade Slash
        [440218] = Defaults(440218), -- Vx: Ice Sickles
        [434779] = Defaults(434779), -- Orator Krix'vizk: Terrorize
        [451543] = Defaults(451543), -- Hollows Resident: Null Slam
        [443500] = Defaults(443500, "SHOCKWAVE"), -- Royal Swarmguard: Earthshatter

        -- The Dawnbreaker 2359
        [427001] = Defaults(427001, "SLAM"), -- Anubikkaj: Terrifying Slam
        [451117] = Defaults(451117, "SLAM"), -- Ixkreten The Unbreakable: Terrifying Slam
        [450854] = Defaults(450854), -- Deathscreamer Iken'tak: Dark Orb
        [426860] = Defaults(426860), -- Anub'ikkaj: Dark Orb
        [431494] = Defaults(431494), -- Nightfall Tactician: Black Edge

        -- The Stonevault 2341
        [425027] = Defaults(425027), -- Earth Infused Golem: Seismic Wave
        [449130] = Defaults(449130), -- Forge Loader: Lava Cannon
        [448640] = Defaults(448640), -- Cursedforge Honor Guard: Shield Stampede
        [427869] = Defaults(427869), -- Void Speaker Eirich: Unbridled Void

        -- Grim Batol 293
        [448105] = Defaults(448105), -- Valiona: Devouring Flame
        [462216] = Defaults(462216), -- Twilight Flamerender: Blazing Shadowflame
        [426893] = Defaults(426893), -- Quartermaster Koratite: Bounding Void
        [447395] = Defaults(447395), -- Forgemaster Throngus: Fiery Cleave
        
        -- Mists of Tirna Scithe 1669
        [321968] = Defaults(321968, "SHOCKWAVE"), -- Tirnenn Villager: Bewildering Pollen
        [323137] = Defaults(323137, "SHOCKWAVE"), -- Droman Oulfarran: Bewildering Pollen
        [340300] = Defaults(340300), -- Mistveil Gorgegullet: Tongue Lashing

        -- Necrotic Wake g410
        [324323] = Defaults(324323), -- Skeletal Marauder: Gruesome Cleave
        [333477] = Defaults(333477), -- Goregrind: Gut Slice
        [333488] = Defaults(333488), -- Amarth: Necrotic Breath
        [323496] = Defaults(323496), -- Flesh Crafter: Throw Cleaver

        -- Siege of Boralus 1162
        [256627] = Defaults(256627, "SHOCKWAVE"), -- Scrimshaw Enforcer: Slobber Knocker
        [257292] = Defaults(257292, "SHOCKWAVE"), -- Irontide Cleaver: Heavy Slash
        [268230] = Defaults(268230), -- Ashvane Deckhand: Crimson Swipe
        [269029] = Defaults(269029), -- Dread Captain Lockwood: Clear The Deck
        
        -- The War Within Dungeons g446,2341

        -- Cinderbrew Meadery
        [436592] = Defaults(436592), -- Goldie Baronbottom: Cash Cannon
        [448619] = Defaults(448619), -- Careless Hopgoblin: Reckless Delivery
        [449090] = Defaults(449090), -- Careless Hopgoblin: Reckless Delivery
        [441119] = Defaults(441119), -- Bee Wrangler: Bee-Zooka
        [432198] = Defaults(432198), -- Brew Master Aldryr: Blazing Belch
        
        -- Darkflame Cleft
        [422414] = Defaults(422414), -- Shuffling Horror: Shadowsmash
        [427025] = Defaults(427025), -- The Darkness: Umbral Slash
        [426261] = Defaults(426261), -- Sootsnout: Ceaseless Flame
        
        -- Priory of the Sacred Flame g446

        -- The Rookery g447
        [445457] = Defaults(445457), -- Voidstone Monstrosity: Oblivion Wave
        [427323] = Defaults(427323), -- Voidrider: Charge Bombardment
        [427616] = Defaults(427616), -- Unruly Stormrook: Energized Barrage

        -- RAIDS

    },

    ["UNIT_SPELLCAST_SUCCEEDED"] = {

        -- SEASON 4

        -- Algethar Academy
        [390938] = Defaults(390938, "SOOTHE", true), -- Aggravated Skitterfly: Agitation
        [387955] = Defaults(387955, "PURGE", true), -- Ethereal Restorer: Celestial Shield
        [377389] = Defaults(377389, "SOOTHE_SPELL", true), -- Alpha Eagle: Call of the Flock
    },
}