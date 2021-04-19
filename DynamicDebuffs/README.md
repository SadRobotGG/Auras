# Dynamic Debuffs

https://wago.io/QyN-tmh2w

Shows your debuffs front and center.

## Features

* Debuffs have a border to identify their spell school (magic: blue, disease: brown, poison: green, curse: purple)
* If your spec can dispel the debuff, the border will be animated
* Custom Options for filtering out some common debuffs you don't want to see
* Enable or disable tooltips for the debuffs
* ElvUI Integration: Control what debuffs you want to show or hide using ElvUI's Blacklist filter

## FAQ

### How do use the ElvUI Blacklist filter to block debuffs I don't want to see

* For the Dynamic Debuffs weak aura `/wa`, go to the Custom Options tab and make sure "Enable ElvUI blocklist" is checked
* In your ElvUI Config `/ec`, go to the Filter section, then under the Main Options tab, choose `Blacklist` from the `Select Filter` drop-down. You can then use the drop-downs to Add, Remove and Search for spells in the Blacklist
* When you configure a spell in the Blacklist, you can configure if it gets shown by the Enable checkbox
* If the spell's `Enable` checkbox is un-checked, then the debuff will **not** be blocked from showing. If the Enable checkbox is checked, then the debuff **will** be blocked from showing in Dynamic Debuffs.

### How can I hide the debuff from Timewarp / Bloodlust etc?

* Go to Custom Options in the Weak Aura and set "Bloodlust / Heroism Debuff" to Hide
* If you're using ElvUI, you can also add the debuffs to the Blacklist

## I want to show or hide the tooltips for the debuffs

* Open the Weak Aura, go to the `Display` tab, then under `Icon Settings`, check or un-check the `Tooltip on Mouseover` option

## Changelog



## Roadmap

* [ ] Show simple information on the debuff e.g. "-15% haste" or "3.6k / 2s". This might be too much noise and I'm unsure on this one.