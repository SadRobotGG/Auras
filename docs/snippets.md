# Lua Snippets

## String manipulation

```lua
"Hello %s!":format("world") -- Hello world!
```

# Weak Auras Snippets

## Units

| Function | |
|----------|--|
| UnitExists(sourceUnit) | Returns if the unit exists |
| UnitAffectingCombat(sourceUnit) | Are we in combat with the unit |
| UnitIsEnemy(sourceUnit, "player") | Is the unit hostile to the player (or specified unit) |
| UnitIsUnit("player", sourceUnit.."target") | Are these two unit names referring to the same unit |
| GetUnitName(sourceUnit) | Get the human-readable name for a unit |

## Entering / Exiting Combat

`PLAYER_REGEN_ENABLED` fires when you leave combat, `PLAYER_REGEN_DISABLED` when you enter combat.

## Debugging Tools

### Built-in Blizzard Debugging Tools

`/eventtrace` or `etrace` to view the Event Tracing window

`framestack` or `fstack` to view all UX frames