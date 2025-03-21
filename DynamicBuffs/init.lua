-- If we're not using ElvUI, we can use their default blacklist instead

local function Defaults(priorityOverride, enabled)
    return {
        enable = enabled or true,
        priority = priorityOverride or 0,
        stackThreshold = 0
    }
end

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
    [306474] = Defaults(), -- Recharging (Mechagon ring Logic Loop proc)
    
    [209388] = Defaults(), -- Bulwark of Order
    --[386652] = Defaults(), -- Bulwark of Righteous Fury
    [132403] = Defaults(), -- Shield of the Righteous
    [393038] = Defaults(), -- Strength in Adversity
    [387678] = Defaults(), -- Dragonrider's Hunt
    
};

aura_env.whitelist = {
    [332514] = { enable = true, priority = 0, stackThreshold = 65}, -- Bron (show at 65 stacks)
    [333961] = Defaults(), -- Bron's Call to Action (Bron active)
    [228050] = Defaults(), -- Guardian of the Forgotten Queen
    [215652] = Defaults(), -- Shield of Virtue
    [974]    = Defaults(), -- Earth Shield
    [327510] = Defaults(), -- Shining Light proc
    [221886] = Defaults(), -- Divine Steed
    [276111] = Defaults(), -- Divine Steed
    [1044]   = Defaults(), -- Blessing of Freedom

    -- Dungeons
    [291937] = Defaults(), -- Hiding Behind Junk (safe against K.U.J.O. in Mechagon Workshop)
    
    -- Trinkets
    [345228] = Defaults(), -- Gladiator's Badge
    
    -- Professions
    [54861] = Defaults(), -- Nitro Boosts
    
    [424956] = Defaults(), -- Candle
    [434696] = Defaults(), -- Stormrook's Favor
    [91374] = Defaults(),  -- Mark of Khadros

    -- World / Quest Buffs
    [1216785] = Defaults(),  -- Glittering Vault Shard
    
}

aura_env.lust = {
    [2825]   = Defaults(),  -- Bloodlust (Shaman Horde)
    [32182]  = Defaults(),  -- Heroism (Shaman Alliance)
    [429485]  = Defaults(),  -- Bloodlust (Shaman Horde)
    [428941]  = Defaults(),  -- Time Warp (Mage)
    [80353]  = Defaults(),  -- Time Warp (Mage)
    [90355]  = Defaults(),  -- Ancient Hysteria (Hunter)
    [264667]  = Defaults(), -- Primal Rage (Hunter)
    [390386]  = Defaults(), -- Fury of the Aspects (Evoker)
}

aura_env.external = {
    [47788]  = Defaults(), -- Guardian Spirit
    [33206]  = Defaults(), -- Pain Suppression
    [116849] = Defaults(), -- Life Cocoon
    [22812]  = Defaults(), -- Barkskin
    [6940]   = Defaults(), -- Blessing of Sacrifice
    [147833] = Defaults(), -- Intervene
    [357170] = Defaults(), -- Time Dilation
    [360827] = Defaults(), -- Blistering Scales
    [1022]   = Defaults(), -- Blessing of Protection
    [204018] = Defaults(), -- Blessing of Spellwarding
    [1044]   = Defaults(), -- Blessing of Freedom
    [228049] = Defaults(), -- Guardian of the Forgotten Queen
    [10060]  = Defaults(), -- Power Infusion
}

aura_env.raidcd = {
    [31821]  = Defaults(), -- Aura Mastery
    [145629] = Defaults(), -- Anti-Magic Zone
    [209426] = Defaults(), -- Darkness
    [81782]  = Defaults(), -- Power Word: Barrier
    [62618]  = Defaults(), -- Barrier
    [204293] = Defaults(), -- Spirit Link    
    [325174] = Defaults(), -- Spirit Link    
    [97462] = Defaults(),  -- Rallying Cry
    [97463] = Defaults(),  -- Rallying Cry
    [374227] = Defaults(),  -- Zephyr
}

aura_env.defense = {
    
    --Death Knight
    [48707]  = Defaults(), -- Anti-Magic Shell
    [195181] = Defaults(), -- Bone Shield
    [81256]  = Defaults(), -- Dancing Rune Weapon
    [383269] = Defaults(), -- Abomination Limb
    [49039]  = Defaults(), -- Lichborne
    [55233]  = Defaults(), -- Vampiric Blood
    [193320] = Defaults(), -- Umbilicus Eternus
    [219809] = Defaults(), -- Tombstone
    [48792]  = Defaults(), -- Icebound Fortitude
    [207319] = Defaults(), -- Corpse Shield
    [194844] = Defaults(), -- BoneStorm
    [194679] = Defaults(), -- Rune Tap

    --Demon Hunter
    [207811] = Defaults(), -- Nether Bond (DH)
    [207810] = Defaults(), -- Nether Bond (Target)
    [187827] = Defaults(), -- Metamorphosis
    [263648] = Defaults(), -- Soul Barrier
    [209426] = Defaults(), -- Darkness
    [196555] = Defaults(), -- Netherwalk
    [212800] = Defaults(), -- Blur
    [188499] = Defaults(), -- Blade Dance
    [203819] = Defaults(), -- Demon Spikes
    -- Druid
    [102342] = Defaults(), -- Ironbark
    [61336]  = Defaults(), -- Survival Instincts
    [210655] = Defaults(), -- Protection of Ashamane
    [22812]  = Defaults(), -- Barkskin
    [200851] = Defaults(), -- Rage of the Sleeper
    [234081] = Defaults(), -- Celestial Guardian
    [202043] = Defaults(), -- Protector of the Pack (it's this one or the other)
    [201940] = Defaults(), -- Protector of the Pack
    [201939] = Defaults(), -- Protector of the Pack (Allies)
    [192081] = Defaults(), -- Ironfur
    --Hunter
    [186265] = Defaults(), -- Aspect of the Turtle
    [53480]  = Defaults(), -- Roar of Sacrifice
    [202748] = Defaults(), -- Survival Tactics
    --Mage
    [45438]  = Defaults(), -- Ice Block
    [113862] = Defaults(), -- Greater Invisibility
    [198111] = Defaults(), -- Temporal Shield
    [198065] = Defaults(), -- Prismatic Cloak
    [11426]  = Defaults(), -- Ice Barrier
    [235313] = Defaults(), -- Blazing Barrier
    --Monk
    [122783] = Defaults(), -- Diffuse Magic
    [122278] = Defaults(), -- Dampen Harm
    [125174] = Defaults(), -- Touch of Karma
    [201318] = Defaults(), -- Fortifying Elixir
    [201325] = Defaults(), -- Zen Moment
    [202248] = Defaults(), -- Guided Meditation
    [120954] = Defaults(), -- Fortifying Brew
    [116849] = Defaults(), -- Life Cocoon
    [202162] = Defaults(), -- Guard
    [215479] = Defaults(), -- Ironskin Brew
    
    --Paladin
    [642]    = Defaults(), -- Divine Shield
    [498]    = Defaults(), -- Divine Protection
    [205191] = Defaults(), -- Eye for an Eye
    [184662] = Defaults(), -- Shield of Vengeance
    [1022]   = Defaults(), -- Blessing of Protection
    [6940]   = Defaults(), -- Blessing of Sacrifice
    [204018] = Defaults(), -- Blessing of Spellwarding
    [199507] = Defaults(), -- Spreading The Word: Protection
    [216857] = Defaults(), -- Guarded by the Light
    [228050] = Defaults(), -- Guardian of the Forgotten Queen
    [31850]  = Defaults(), -- Ardent Defender
    [31884]  = Defaults(), -- Avenging Wrath
    [86659]  = Defaults(), -- Guardian of Ancient Kings
    [212641] = Defaults(), -- Guardian of Ancient Kings (Glyph of the Queen)
    [209388] = Defaults(), -- Bulwark of Order
    [204335] = Defaults(), -- Aegis of Light
    [152262] = Defaults(), -- Seraphim
    [132403] = Defaults(), -- Shield of the Righteous
    [355455] = Defaults(), -- Divine Resonance
    [389539] = Defaults(), -- Sentinel
    [223819] = Defaults(), -- Divine Purpose
    -- Paladin Hero Talents
    [431536] = Defaults(), -- Shake the Heavens
    [387792] = Defaults(), -- Empyrael Ward
    [432607] = Defaults(), -- Holy Armaments (Holy Bulwark)
    [432502] = Defaults(), -- Holy Armaments (Sacred Weapon)
    
    --Priest
    [81782]  = Defaults(), -- Power Word: Barrier
    [47585]  = Defaults(), -- Dispersion
    [19236]  = Defaults(), -- Desperate Prayer
    [213602] = Defaults(), -- Greater Fade
    [27827]  = Defaults(), -- Spirit of Redemption
    [197268] = Defaults(), -- Ray of Hope
    [47788]  = Defaults(), -- Guardian Spirit
    [33206]  = Defaults(), -- Pain Suppression
    --Rogue
    [5277]   = Defaults(), -- Evasion
    [31224]  = Defaults(), -- Cloak of Shadows
    [1966]   = Defaults(), -- Feint
    [199754] = Defaults(), -- Riposte
    [45182]  = Defaults(), -- Cheating Death
    [199027] = Defaults(), -- Veil of Midnight
    --Shaman
    [204293] = Defaults(), -- Spirit Link
    [204288] = Defaults(), -- Earth Shield
    [210918] = Defaults(), -- Ethereal Form
    [207654] = Defaults(), -- Servant of the Queen
    [108271] = Defaults(), -- Astral Shift
    [98007]  = Defaults(), -- Spirit Link Totem
    [207498] = Defaults(), -- Ancestral Protection
    --Warlock
    [108416] = Defaults(), -- Dark Pact
    [104773] = Defaults(), -- Unending Resolve
    [221715] = Defaults(), -- Essence Drain
    [212295] = Defaults(), -- Nether Ward
    --Warrior
    [118038] = Defaults(), -- Die by the Sword
    [184364] = Defaults(), -- Enraged Regeneration
    [209484] = Defaults(), -- Tactical Advance
    [97463]  = Defaults(), -- Commanding Shout
    [213915] = Defaults(), -- Mass Spell Reflection
    [199038] = Defaults(), -- Leave No Man Behind
    [223658] = Defaults(), -- Safeguard
    [147833] = Defaults(), -- Intervene
    [198760] = Defaults(), -- Intercept
    [12975]  = Defaults(), -- Last Stand
    [871]    = Defaults(), -- Shield Wall
    [23920]  = Defaults(), -- Spell Reflection
    [216890] = Defaults(), -- Spell Reflection (PvPT)
    [227744] = Defaults(), -- Ravager
    [203524] = Defaults(), -- Neltharion's Fury
    [190456] = Defaults(), -- Ignore Pain
    [132404] = Defaults(), -- Shield Block
    
    -- Trinkets
    [358712] = Defaults(), -- Annhlyde's Aegis
    [329849] = Defaults(), -- Blood-Spattered Scale
    [435482] = Defaults(), -- Spymaster's Web
    [431932] = Defaults(), -- Tempered Potion
    
    -- Racial
    [65116] = Defaults(), -- Stoneform (Dwarf)
}


-- for index,value in pairs(aura_env.whitelist) do
--     print("aura_env.whitelist["..tostring(index).."]={")
--     for i,v in pairs(value) do 
--         print("  "..tostring(i).."="..tostring(v));
--     end
--     print("}")
-- end


-- If we don't use ElvUI, then just stick to the defaults.
if not ElvUI then return true end

local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

aura_env.blacklist = {} -- ElvDB.global.unitframe.aurafilters.Blacklist.spells;

