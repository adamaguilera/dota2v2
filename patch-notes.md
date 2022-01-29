# DOTA2v2 Patch Notes
v1.3.7: bottle / deficit changes
- increased max bottle charges back to 3
- added 2 additional random bans over time
- fixed issue with player disconnect not causing modifier to show up
- increaesed deficit creep damage scaling from 1.45 to 1.5
- increased deficit creep health scaling from 20 to 22 
- decreased respawn timer for deficit team by 70%
- deficit gold multiplier reduced from 1.5 to 1.4 (addon description was inaccurate lul)
- deficit experience multiplier increased from 1.5 to 1.8

## Future ideas
- GG feature
    - On typing GG in all chat, player is permantely stunned and counted as 'disconnected'
    - A player can type ungg in all chat to remove this effect and 'reconnect'
    - If all players on a team are GG'd then the game ends in 10s
- Data logging
    - Track damage values and recreate post game summary
- 1v1 map

## Previous Patches
v1.3.6: bug fixes, tome changes
- fixed neutral items past tier 1 not spawning
- tome of knowledge base XP increased from 400 to 600
- tome of knowledge now buyable at 4 minutes (previously 2m)

v1.3.5: bug fixes, ward nerfs and skylighter nerfs
- fixed map minimap render on 2v2 map
- after ban stage, a random hero choice is periodically banned to help those struggling choose :)
- observer wards initial stock from 2 to 1
- observer wards restock time from 135 to 150
- observer wards duration reduced from 360 to 240
- sentry wards cost reduced from 50 to 25
- sentry wards initial stock set to 0
- sentry ward duration reduced from 420 to 300
- tome of knowledge cost reduced from 200 to 150
- reduced cost of TP scroll from 100 to 60
- increased cost of bots recipe from 1500 to 2000
- bottle now has 2 MAX charges

v1.3.4: bug fix
- added 30s delay to players disconnect

v1.3.3: xp changes, player deficit and QOL changes
- Increased creep XP multiplier to 1.85
- Increased outpost XP to 600XP
- Decreased neutral gold multiplier to 1.32
- Player deficit (less players than other team) now works on player disconnect
- Player deficit multipliers now dependent on amount of players less team has than other team
- Player deficit now has a modifier to show players they are getting a buff
- Shrine initial CD now 120s done
- Increased roshan bounty to 1000 - 2000
- Increased roshan XP from 800 -> 1000
- Decreased roshan respawn range from 240s -> 360s to 220s -> 320s
- Shared gold nerfed 80% -> 66%
- Missed gold buffed 12% -> 20%
- Respawn reduction from 65% -> 72%
- Glyph CD now 200s
- Runes spawn every 3 minutes instead of 2
- POG Runes no longer player global sound
- Witless shacko now a tier 4 (previously tier 3)
- Tier 4's now spawn at 16 minutes
- Tier 5's now spawn at 22 minutes

v1.3.2: xp / gold / outpost changes
- Decreased hero kill multiplier to 1.15
- Decreased creep gold multiplier to 1.32
- Decreased creep XP multiplier to 1.80
- Neutral creep XP multiplier now 2.25
- Outposts are invulnerable for first 5 minutes
- Outposts now grant 500XP every 5 minutes
- Decreased cooldown on TP scroll to 50s
- Decreased travel boots recipe to 1500
- Increased shrine cooldown to 180s
- Increased passive XP (40XP for each level behind max every 30s)
- Increased Roshan bounty to 800 - 1500 (before multiplier)
- Increased Roshan XP to 800 (before multiplier)
- Added more ward spots
- Added new path to top lane jungle for both teams
- Reduce respawn timer now 65% (previously 82%)
- Reduced max respawn timer to 60
- Glyph cd now 240s

## Previous Patches
v1.3.1: map bug
- fixed shrine bug

v1.3: general improvements
- gameplay improvements
    - Increased XP multiplier to 2.05
    - Added passive XP to players with lower level than highest level player (30XP every 15s)
    - Each outpost now grant 250 XP at the end of every minute
- map improvements (3v3 / 4v4)
    - Moved shrine next to first tower
    - Fixed creeps not aggroing ancient
    - Fixed shrines not being targetable after destroying tower
    - Improved player exclusion zone
    - Roshan respawn now 4 minutes - 6 minutes
    - added trees to midlane
- neutral items
    - removed phoenix ash, mango tree and gem neutral item (while they are bugged)
    - decreased max tier 1 neutral items to 2
- Fixes to tome
    - Initial restock delay to 4 minutes
    - Restocks every 2 minutes 
    - Reduced base XP to 400
    - Increase additional XP per tome use to 300
    - Price increased to 200
- Increased penalty time to 5s before random


v1.21: github
- Added code to github

v1.2: roshan / shop fix
- fixed roshan aggroing forever, will act normally
- fixed secret shop
- removed rune attacks (for now ?)
- moved first tower closer to mid lane

v1.1: mapfix

v1.0: Major release 3v3 jungle map
- New 3v3 map with the following features:
    - Roshan, outposts and a shrine
    - added player restricted areas to stop cliff camping on edge of map
    - honestly too many I can think the map is just better
- 4v4 will now use jungle map
- made changes to runes so they only last 30 seconds

v0.8: comestic map change
- Increased size of map to improve look of edge paning

v0.7: 4v4 scaling changes
- Removed 4v4 gold scaling
- Decreased shared gold percent
- Decreased missed gold percent
- Decreased 4v4 xp scaling

v0.6: neutral buff, shared missed gold
- Increased neutral and lane gold
- Increase neutral experience by 15 with minor scaling based on gametime 
- Rune armor increased to 5, magic res decreased to 80% and health decreased to 80
- Added shared missed gold from missed last hits at 25% bounty

v0.5: quick scaling fix
- Slightly decreased damage scaling on creeps in 4v4
- Decreased team deficit damage
- Siege now spawns at 8 minutes
- Minor tweeks to neutrals
- Increased shared gold to 82%

v0.4: Bug fix
- Fixed 4v4 damage scaling bug
- Fixed mana regen on rune
- Regen rune now gives 40+4.2% hp and 24+3.2% mana
- Decrease lane rune spawn to 10%
- Increased jungle rune spawn to 20%
- Increased 4v4 gold/xp scaling

v0.3: Neutral items 
- Neutral items are now better aligned with 
game mechanics 
- Every 5 minutes the next tier is droppable 
- Droprates are 20%, 15%, 12%, 8%, 5% for 
the five items in each tier 
- Neutral items include previously removed 
ones so be sure to check at the start of the 
game which you can find!
- Decreased max penalty time to 10s

v0.2: Rune changes
- Changed mechanics of regen rune from last hits
- Regen runes from last hits will now have 100 health
100% magic resistance, 4 armor and the unit that destroys this
now receives the buff instead of automatically getting it
from a last hit
- Increased odds of rune drop to 18% in jungle
(12% in lane)
- Buffed base hp regen from rune to 34
- Dramatically decreased volume of regen rune, it was loud...
- Adjusted shard stock to account for pregame timer

v0.1 - shard / siege
- Made shard stock at 7 min 
- Added siege creeps spawns at 10 min 
- Made creep scaling linear (previously percent based) 
- Increased creep damage scaling 
- Decreased creep health scaling 
- Buffed regen rune mana heal base to 12 
- Changed bounty rune calculations (number inaccurate in chat though) 
- Fixed bug where double damage rune didn't spawn 
- Removed shield blaster (lol) 