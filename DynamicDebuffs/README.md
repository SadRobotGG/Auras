# Dynamic Debuffs

https://wago.io/QyN-tmh2w

Shows your debuffs front and center.

Source code and Issue tracking @ GitHub: https://github.com/SadRobotGG/Auras/tree/main/DynamicDebuffs

## Features

* Debuffs have a border to identify their spell school (magic: blue, disease: brown, poison: green, curse: purple)
* If your spec and talents can dispel the debuff, the border will be animated
* Custom Options for filtering out some common debuffs you don't want to see
* Enable or disable tooltips for the debuffs
* ElvUI Integration: Control what debuffs you want to show or hide using ElvUI's Blacklist filter

## FAQ

### How can I show / hide the debuff from Timewarp / Bloodlust or Forbearance?

* Go to Custom Options in the Weak Aura and set `Bloodlust / Heroism Debuff` or `Forbearance` to `Hide` or `Show`
* If you're using ElvUI, you can also add the debuffs to the Blacklist

## I want to show or hide the tooltips for the debuffs

* Open the Weak Aura, go to the `Display` tab, then under `Icon Settings`, check or un-check the `Tooltip on Mouseover` option

### How can I use the ElvUI Blacklist filter to block debuffs I don't want to see

* For the Dynamic Debuffs weak aura `/wa`, go to the Custom Options tab and make sure `Enable ElvUI blocklist` is checked
* In your ElvUI Config `/ec`, go to the `Filters` section, then under the `Main Options` tab, choose `Blacklist` from the `Select Filter` drop-down. You can then use the drop-downs to Add, Remove and Search for spells in the Blacklist
* When you configure a spell in the Blacklist, you can configure if it gets shown by the Enable checkbox
* If the spell's `Enable` checkbox is un-checked, then the debuff will **not** be blocked from showing. If the Enable checkbox is checked, then the debuff **will** be blocked from showing in Dynamic Debuffs.
* If you choose `Disable` or `Enable` for debuffs in the Dynamic Debuffs `Custom Options`, this will override the ElvUI Blacklist.

## Changelog

### 10.2.6 Dragonflight Season 4

- Added support for Evoker dispels
- Better support for detecting if you can dispel a debuff by checking your spec and talents
- Complete rewrite for much-improved performance

## Roadmap

* [ ] Show simple information on the debuff e.g. "-15% haste" or "3.6k / 2s". This might be too much noise and I'm unsure on this one.