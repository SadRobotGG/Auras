# Lua Snippets

## String manipulation

```lua
"Hello %s!":format("world") -- Hello world!
```

## Blizzard API

### Units

| Function | |
|----------|--|
| UnitExists(sourceUnit) | Returns if the unit exists |
| UnitAffectingCombat(sourceUnit) | Are we in combat with the unit |
| UnitIsEnemy(sourceUnit, "player") | Is the unit hostile to the player (or specified unit) |
| UnitIsUnit("player", sourceUnit.."target") | Are these two unit names referring to the same unit |
| GetUnitName(sourceUnit) | Get the human-readable name for a unit |

## Events
### Entering / Exiting Combat

`PLAYER_REGEN_ENABLED` fires when you leave combat, `PLAYER_REGEN_DISABLED` when you enter combat.

### Stats updated

Events to monitor that can change player stats, so you can update displays reactively instead of updating every frame.

PLAYER_ENTERING_WORLD
CHARACTER_POINTS_CHANGED
UNIT_MODEL_CHANGED
UNIT_LEVEL
UNIT_STATS
UNIT_RANGEDDAMAGE
UNIT_ATTACK_POWER
UNIT_RANGED_ATTACK_POWER
UNIT_ATTACK
UNIT_SPELL_HASTE
UNIT_RESISTANCES
PLAYER_GUILD_UPDATE
SKILL_LINES_CHANGED
COMBAT_RATING_UPDATE
MASTERY_UPDATE
SPEED_UPDATE
LIFESTEAL_UPDATE
AVOIDANCE_UPDATE
PLAYER_TALENT_UPDATE
PLAYER_EQUIPMENT_CHANGED
PLAYER_AVG_ITEM_LEVEL_UPDATE
PLAYER_DAMAGE_DONE_MODS
ACTIVE_TALENT_GROUP_CHANGED
UNIT_DAMAGE
UNIT_ATTACK_SPEED
UNIT_MAXHEALTH
UNIT_AURA
SPELL_POWER_CHANGED
CHARACTER_ITEM_FIXUP_NOTIFICATION
TRIAL_STATUS_UPDATE

## Debugging Tools

### Built-in Blizzard Debugging Tools

`/eventtrace` or `/etrace` to view the Event Tracing window

`/framestack` or `/fstack` to view all UX frames

`/tableinspect <global>` or `/tinspect <global>` to inspect a global table. If no table is specified, inspects the UI widget under the mouse cursor.
Opens the table inspector.
