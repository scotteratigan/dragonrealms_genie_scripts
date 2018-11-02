#REQUIRE Stow.cmd
#REQUIRE Warning.cmd
#REQUIRE Wear.cmd

# Usage: gosub clear right/left/both
# #var itemwearlist light crossbow|leather backpack to set those items worn
# #var nounwearlist crossbow|backpack for a more generic setting (be careful!)
# Todo: forging gear lists (will need to require put & tie at that point?)
# Note: originally named Clear.cmd but you cannot 'gosub Clear' because that's a reserved word.

gosub ClearHand %0
exit

ClearHand:
	eval Clear.option tolower("$0")
	var Clear.success 0
ClearingHand:
	if (contains("left|both", "%Clear.option")) then gosub ClearLeft
	if (contains("right|both", "%Clear.option")) then gosub ClearRight
	if ("$lefthand $righthand" == "Empty Empty") then var Clear.success 1
	return

ClearLeft:
	if ("$lefthand" == "Empty") then return
	var Clear.item $lefthand
	var Clear.id #$lefthandid
	var Clear.noun $lefthandnoun
	gosub ClearNow
	return

ClearRight:
	if ("$righthand" == "Empty") then return
	var Clear.item $righthand
	var Clear.id #$righthandid
	var Clear.noun $righthandnoun
	gosub ClearNow
	return

ClearNow:
	if (contains("|$itemwearlist|", "|%Clear.item|")) then {
		gosub Wear %Clear.id
		if ("%Wear.success" == "1") then return
		gosub Warning Tried to wear %Clear.item because it's in itemwearlist ($itemwearlist) but failed.
	}
	if (contains("|$itemnounlist|", "|%Clear.noun|")) then {
		gosub Wear %Clear.id
		if ("%Wear.success" == "1") then return
		gosub Warning Tried to wear %Clear.item because it's in itemwearlist ($itemwearlist) but failed.
	}
	gosub Stow %Clear.id
	return