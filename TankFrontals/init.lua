--Events: UNIT_SPELLCAST_START:nameplate UNIT_SPELLCAST_SUCCEEDED:nameplate PLAYER_REGEN_ENABLED NAME_PLATE_UNIT_ADDED NAME_PLATE_UNIT_REMOVED

-- Contains a table of units we want to rapidly scan for their target briefly to help determine who the frontal is on.
aura_env.unitTargetScans = {}

local TimerAfter = C_Timer.After
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitName = UnitName
local UnitTokenFromGUID = UnitTokenFromGUID
local UnitGUID = UnitGUID
local UnitIsPlayer = UnitIsPlayer

-- Zone filters Season 1: g450,g448,2359,2341,293,1669,g410,1162
-- Zone filters TWW Dungeons: g446,2341,g447
-- Zone filters: g450,g448,2359,2341,293,1669,g410,1162,g446,2341,g447,2335
-- g450,g448,2359,2341,293,1669,g410,1162,g446,2341,g447,2303
local o = aura_env.config

aura_env.SpellType = EnumUtil.MakeEnum(
    "Frontal",
    "Slam",
    "Shockwave",
    "Knockback",
    "Purge",
    "Soothe",
    "SootheSpell",
    "PurgeSpell",
    "SpellTarget",
    "Stack"
);

aura_env.TargetDetection = EnumUtil.MakeEnum("Auto", "Ignore", "Scan");

-- local spec, role, pos = WeakAuras.SpecRolePositionForUnit("player")
aura_env.isTank = select(5, GetSpecializationInfo(GetSpecialization())) == "TANK";

aura_env.captions = {
    [aura_env.SpellType.Frontal] = o.frontal or ">> FRONTAL ON ME <<",
    [aura_env.SpellType.Slam] = o.slam or ">> SLAM ON ME <<",
    [aura_env.SpellType.Shockwave] = o.shockwave or ">> SHOCKWAVE ON ME <<",
    [aura_env.SpellType.Knockback] = o.knockback or ">> KNOCKBACK ON ME <<",
    [aura_env.SpellType.Purge] = o.purge or ">> PURGE %s! <<",
    [aura_env.SpellType.Soothe] = o.soothe or ">> SOOTHE %s! <<",
    [aura_env.SpellType.SootheSpell] = o.sootheSpell or ">> SOOTHE %2$s! <<",
    [aura_env.SpellType.PurgeSpell] = o.purgeSpell or ">> PURGE %2$s! <<",
    [aura_env.SpellType.SpellTarget] = o.spellTarget or ">> %2$s on %3$s <<",
    [aura_env.SpellType.Stack] = o.stack or ">> STACK FOR %2$s <<",
}

-- Initialize the frontal / alert types
aura_env.types = {}

local frontalTypes = {
    {
        message = ">> FRONTAL ON ME <<",
        name = "Frontal",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Front.ogg",
        textToSpeech = "Frontal",
        type = 1,
    },
    {
        message = ">> SLAM ON ME <<",
        name = "Slam",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\AoE.ogg",
        textToSpeech = "Slam",
        type = 2,
    },
    {
        message = ">> SHOCKWAVE ON ME <<",
        name = "Shockwave",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Dodge.ogg",
        textToSpeech = "Sidestep",
        type = 3,
    },
    {
        message = ">> KNOCKBACK ON ME <<",
        name = "Knockback",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Knock.ogg",
        textToSpeech = "Knockback",
        type = 4,
    },
    {
        message = ">> PURGE %s! <<",
        name = "Purge",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Dispell.ogg",
        textToSpeech = "Purge %s",
        type = 5,
    },
    {
        message = ">> SOOTHE %s! <<",
        name = "Soothe",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Dispell.ogg",
        textToSpeech = "Soothe %s",
        type = 6,
    },
    {
        message = ">> STACK FOR %2$s <<",
        name = "Stack",
        sound = "Interface\\\\Addons\\\\SharedMedia_Causese\\\\sound\\\\Stack.ogg",
        textToSpeech = "Stack for %2$s",
        type = 7,
    }
}

-- If there's no default frontal types, create the defaults
if not aura_env.config.types or not type(aura_env.config.types) == "table" or #aura_env.config.types == 0 then
    aura_env.config.types = {}
end

-- Initialize the frontal types if they've been reset or mangled
for i = 1, 7 do
    local defaultFrontal = frontalTypes[i]
    -- If there's no type at this index, add the default
    if not aura_env.config.types[i] or not type(aura_env.config.types[i]) == "table" then
        aura_env.config.types[i] = defaultFrontal
    else
        local v = aura_env.config.types[i]
        aura_env.config.types[i] = {
            type = defaultFrontal.type,
            name = defaultFrontal.name,
            message = v.message or defaultFrontal.message,
            sound = v.sound or defaultFrontal.sound,
            textToSpeech = v.textToSpeech or defaultFrontal.textToSpeech,
        }
    end

    aura_env.types[i] = aura_env.config.types[i]
end

local spellList = {
          -- Ara-Kara, City of Echoes g450
          { desc= "Anubzekt: Impale", duration= 3.3, spellId= 435012, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Hulking Bloodguard: Impale", duration= 2.5, spellId= 453161, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          --{ desc= "Atik: Web Spray", duration= 3.3, spellId= 434824, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },

          -- City of Threads g448
          { desc= "Nx: Shade Slash", duration= 2.5, spellId= 439621, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Vx: Freezing Blood", duration= 2, spellId= 440468, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Stack },
          { desc= "Orator Krix'vizk: Terrorize", duration= 2.5, spellId= 434779, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Eye Of The Queen: Null Slam", duration= 2.5, spellId= 451543, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Royal Swarmguard: Earthshatter", duration= 3, spellId= 443500, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Izo The Grand Splicer: Process of Elimination", duration= 2.9, spellId= 439646, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Slam },

          -- The Dawnbreaker 2359
          { desc= "Anubikkaj: Terrifying Slam", duration= 2.5, spellId= 427001, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Slam },
          --{ desc= "Anub'ikkaj: Dark Orb", duration= 3.3, spellId= 426860, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Ixkreten The Unbreakable: Terrifying Slam", duration= 2.5, spellId= 451117, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Slam },
          --{ desc= "Deathscreamer Iken'tak: Dark Orb", duration= 3.3, spellId= 450854, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Nightfall Tactician: Black Edge", duration= 2.5, spellId= 431494, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },

          -- Grim Batol 293
          { desc= "Valiona: Devouring Flame", duration= 3.3, spellId= 448105, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Twilight Flamerender: Blazing Shadowflame", duration= 2.5, spellId= 462216, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Forgemaster Throngus: Fiery Cleave", duration= 2.5, spellId= 447395, target= aura_env.TargetDetection.Scan, targetTimer=0.2, type= aura_env.SpellType.Shockwave },

          -- Mists of Tirna Scithe 1669
          { desc= "Tirnenn Villager: Bewildering Pollen", spellId= 321968, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Droman Oulfarran: Bewildering Pollen", duration= 2.9, spellId= 323137, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Mistveil Gorgegullet: Tongue Lashing", duration= 1.7, spellId= 340300, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Mistveil Matriarch: Radiant Breath", duration= 2.4, spellId= 340160, target= aura_env.TargetDetection.Scan, targetTimer=0.2, type= aura_env.SpellType.Shockwave },

          -- Necrotic Wake g410
          { desc= "Skeletal Marauder: Gruesome Cleave", duration= 0.83, spellId= 324323, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Frontal },
          --{ desc= "Goregrind: Gut Slice", duration= 1.7, spellId= 333477, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Frontal },
          { desc= "Amarth: Necrotic Breath", duration= 1.3, spellId= 333488, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Frontal },
          { desc= "Flesh Crafter: Throw Cleaver", duration= 3.3, spellId= 323496, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Zolramus Sorcerer: Shadow Well", duration= 0.5, spellId= 320464, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Slam },

          -- Siege of Boralus 1162
          { desc= "Scrimshaw Enforcer: Slobber Knocker", duration= 1.7, spellId= 256627, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Knockback },
          { desc= "Irontide Cleaver: Heavy Slash", duration= 2.3, spellId= 257292, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Ashvane Deckhand: Crimson Swipe", duration= 0.96, spellId= 268230, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Frontal },
          { desc= "Ashvane Cannoneer: Broadside", duration= 2.5, spellId= 268260, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Dread Captain Lockwood: Clear The Deck", duration= 2.5, spellId= 269029, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Hadal Darkfathom: Crashing Tide", duration= 2.5, spellId= 257862, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },

          -- The Stonevault 2341
          { desc= "Earth Infused Golem: Seismic Wave", duration= 2.5, spellId= 425027, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Forge Loader: Lava Cannon", duration= 2.5, spellId= 449130, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Cursedforge Honor Guard: Shield Stampede", duration= 4.2, spellId= 448640, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          { desc= "Void Speaker Eirich: Unbridled Void", duration= 3.8, spellId= 427869, target= aura_env.TargetDetection.Scan, targetTimer= 0.2, type= aura_env.SpellType.Shockwave },
          
          -- The Rookery g447
          { desc= "Quartermaster Quaratite: Bounding Void", spellId= 426893, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Shockwave },
          { desc= "Voidstone Monstrosity: Oblivion Wave", duration= 2.5, spellId= 445537, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Frontal },
          { desc= "Voidrider: Charge Bombardment", duration= 2.5, spellId= 427323, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Slam },
          { desc= "Unruly Stormrook: Energized Barrage", duration= 2.5, spellId= 427616, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Slam },

          -- Cinderbrew Meadery 2335
          { desc= "Goldie Baronbottom: Cash Cannon", duration= 2.5, spellId= 436592, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Knockback },
          { desc= "Careless Hopgoblin: Reckless Delivery", duration= 2.5, spellId= 448619, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Frontal },
          { desc= "Careless Hopgoblin: Reckless Delivery", duration= 2.5, spellId= 449090, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Frontal },
          { desc= "Bee Wrangler: Bee-Zooka", duration= 2.5, spellId= 441119, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Knockback },
          { desc= "Brew Master Aldryr: Blazing Belch", duration= 2.5, spellId= 432198, target= aura_env.TargetDetection.Scan, targetTimer= 0, type= aura_env.SpellType.Frontal },

          -- Priory of the Sacred Flame g446

          -- Darkflame Cleft 2303
          { desc= "Shuffling Horror: Shadowsmash", duration= 2.5, spellId= 422414, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Slam },
          { desc= "The Darkness: Umbral Slash", duration= 2.5, spellId= 427025, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Frontal },
          { desc= "Sootsnout: Ceaseless Flame", duration= 2.5, spellId= 426261, target= aura_env.TargetDetection.Auto, targetTimer= 0, type= aura_env.SpellType.Shockwave },

};

-- Initialize the spells
aura_env.spells = {}
for _, v in ipairs(spellList) do
    if type(v) == "table" then

        -- Get the spell details
        local spellInfo = C_Spell.GetSpellInfo(v.spellId)

        local userOption = aura_env.config["spell"..v.spellId]

        local enabled = userOption == nil or userOption == true;

        if not spellInfo or not enabled or v.disabled == true then
            -- Can't detect, or it's disabled
            DebugPrint("Unknown or disable: "..v.spellId)
        else
            local castTime = spellInfo.castTime and spellInfo.castTime / 1000 or 0
            if v.spellId == 321968 then
                DebugPrint("castTime: "..spellInfo.castTime)
                DebugPrint("castTime secs: "..castTime)
            end
            aura_env.spells[v.spellId] = {
                spellId = v.spellId,
                --disabled = not enabled,
                duration = castTime or v.duration,
                type = v.type,
                icon = spellInfo and spellInfo.iconID,
                name = spellInfo and spellInfo.name or "Unknown",
                target = v.target,
                targetTimer = v.targetTimer or 0.2,
            }
        end

    end
end

-- Local functions

local function IsTanking(targetUnit, sourceUnit)
    local isTanking, status = UnitDetailedThreatSituation(sourceUnit or "player", targetUnit)
    return isTanking or status == 2 or status == 3
end

local function GetUnitName(unit)
    local name, server = UnitName(unit)
    if not name then
        return
    elseif server and server ~= "" then
        name = name .."-".. server
    end
    return name
end

local unitTable = {
    "boss1", "boss2", "boss3", "boss4", "boss5",
    "target", "targettarget",
    "mouseover", "mouseovertarget",
    "focus", "focustarget",
    "nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
    "nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
    "nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
    "nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40",
    "party1target", "party2target", "party3target", "party4target"
}
local unitTableCount = #unitTable
local function FindTargetByGuid(id)
    --DebugPrint("FindTargetByGuid("..id..")")
    local isNumber = type(id) == "number"
    if not isNumber and UnitTokenFromGUID then
        if UnitExists(id) then
            --DebugPrint("Found FindTargetByGuid("..id..") = "..id);
            return id
        end
        local unit = UnitTokenFromGUID(id)
        if unit then 
            --DebugPrint("Found UnitTokenFromGUID("..id..") = "..unit);
            return unit
        end
    end
    for i = 1, unitTableCount do
        local unit = unitTable[i]
        local guid = UnitGUID(unit)
        if guid and not UnitIsPlayer(unit) then
            if isNumber then
                local _, _, _, _, _, mobId = strsplit("-", guid)
                guid = tonumber(mobId)
            end
            if guid == id then return unit end
        end
    end
end

local function GetNpcId(guid)
    local _, _, _, _, _, npcId = strsplit("-", guid)
    return tonumber(npcId)
end

-- Concept from BigWigs, that tries to scan the target of a unit to get their target
-- so that we can see their last target when they case a frontal, so we can determine
-- if it's on us or not, if we're not the tank.
local function UnitScanner()
    for i = #aura_env.unitTargetScans, 1, -1 do
        local self, func, checkTimeLimit, payload = aura_env.unitTargetScans[i][1], aura_env.unitTargetScans[i][2], aura_env.unitTargetScans[i][3], aura_env.unitTargetScans[i][4]
        local elapsed = aura_env.unitTargetScans[i][5] + 0.05
        aura_env.unitTargetScans[i][5] = elapsed
        local guid = payload.sourceUnit
        local unit = FindTargetByGuid(guid)
        if unit then
            local unitTarget = unit.."target"
            local targetGuid = UnitGUID(unitTarget)
            if targetGuid then
                payload.destinationName = GetUnitName(unitTarget)
                payload.destinationUnit = targetGuid
                DebugPrint(unitTarget.."="..targetGuid)
                if not IsTanking(unit, unitTarget) or elapsed > checkTimeLimit or elapsed > 0.8 then
                    payload.isTarget = UnitIsUnit("player", unitTarget) or elapsed > checkTimeLimit
                    tremove(aura_env.unitTargetScans, i)
                    func(payload, elapsed)
                end
            elseif elapsed > checkTimeLimit then
                DebugPrint("Timed out")
                tremove(aura_env.unitTargetScans, i)
                payload.isTarget = false
                func(payload, elapsed)
            end
        elseif elapsed > 0.8 then
            tremove(aura_env.unitTargetScans, i)
        end
    end

    if #aura_env.unitTargetScans ~= 0 then
        TimerAfter(0.05, UnitScanner)
    end
end

-- Exposed functions

-- Register a callback to get the first non-tank target of a mob.
-- Looks for the unit as defined by the GUID and then returns the target of that unit.
-- If the target is a tank, it will keep looking until the designated time has elapsed.
-- @param func callback function, passed (module, playerName, playerGUID, elapsed)
-- @number checkTimeLimit seconds to wait, if a tank is still the target after this time, it will return the tank as the target (max 0.8)
-- @string guid GUID of the mob to get the target of
aura_env.GetUnitTarget = function (callback, payload)-- checkTimeLimit, unitGuid)
    
    local checkTimeLimit = payload.info.targetTimer or 0.2
    if not checkTimeLimit or checkTimeLimit <= 0 then checkTimeLimit = 0.2 end

    --DebugPrint("GetUnitTarget("..checkTimeLimit..", "..payload.sourceUnit..")")
    
    if #aura_env.unitTargetScans == 0 then
        TimerAfter(0.05, UnitScanner)
    end
    aura_env.unitTargetScans[#aura_env.unitTargetScans+1] = {self, callback, checkTimeLimit, payload, 0}
end
