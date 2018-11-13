#REQUIRE Accept.cmd
#REQUIRE Ask.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Fill.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Look.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE Nounify.cmd
#REQUIRE Order.cmd
#REQUIRE Pour.cmd
#REQUIRE RunScripts.cmd
#REQUIRE Task.cmd
#REQUIRE Trash.cmd
#REQUIRE FestTrashOrKeep.cmd
#REQUIRE Wealth.cmd
#REQUIRE Withdraw.cmd

# Note: changing the return condition here. Also returns after task is completed now. That way, I can play boggle blast between tasks.

put #window add Treasure
var FestGivePoltuItems.lastPoltuRoom -1
gosub FestGivePoltuItems %1
exit

FestGivePoltuItems:
	var FestGivePoltuItems.noun $1
	var FestGivePoltuItems.oilItemsBeforeGiving 0
	if ("%FestGivePoltuItems.noun" == "rasp") then var FestGivePoltuItems.oilItemsBeforeGiving 1
	action var FestGivePoltuItems.poltuDirection $1 when ^Dealer Poltu goes (.+)\.$
	gosub Wealth
	var FestGivePoltuItems.dokoras %Wealth.dokoras
	if (%FestGivePoltuItems.dokoras < 5000) then {
		gosub Navigate 210 teller
		gosub Withdraw 5 platinum
	}
	if (!contains("$roomobjs", "Poltu")) then {
		gosub FestGivePoltuItemsFindPoltu
		goto FestGivePoltuItems
	}
	gosub Task
	if (%Task.inProgress == 0) then {
		gosub Ask Poltu for task
		if (%Ask.success != 1) then {
			pause 10
			goto FestGivePoltuItems
		}
		gosub Accept task
	}
FestTurningInItems:
	if (!contains("$roomobjs", "Poltu")) then {
		gosub FestGivePoltuItemsFindPoltu
		goto FestTurningInItems
	}
	gosub Get my %FestGivePoltuItems.noun
	if (%Get.success == 0) then return
	if (%FestGivePoltuItems.oilItemsBeforeGiving == 1) then {
		if ("$lefthand" != "oil") then {
			gosub Get my oil
			if (%Get.success != 1) then {
				# Go buy oil if I don't have any on hand.
				gosub ClearHand both
				gosub Navigate 150 ForgingTools
				gosub Order 6
				if (%Order.success != 1) then return
				gosub ClearHand both
				goto FestGivePoltuItems
			}
		}
		gosub Pour my oil on my %FestGivePoltuItems.noun
		#if (%Pour.success != 1) then return <- disabled because I already oiled some
	}
	gosub Give Poltu
	if (%Give.success != 1) then {
		if (!contains("$roomobjs", "Poltu")) then goto FestTurningInItems
		# If Poltu is in the room, but I failed to give an item, I must be out. Returning out of entire function.
		return
	}
	if !contains("$lefthand $righthand", "woven sack") then goto FestTurningInItems
# Ok, now parse the treasure:
	gosub ClearHand left
	gosub Navigate 210 Spinneret
	gosub Look in my woven sack
	put #echo >Treasure white %Look.contents
FestGivePoltuItemsGetCoins:
	gosub Get coin
	if (%Get.success == 1) then goto FestGivePoltuItemsGetCoins
	gosub Fill my gem pouch with my woven sack
	gosub Look in my woven sack
FestGivePoltuItemsGetItem:
	eval FestGivePoltuItems.itemToGet element("%Look.contentsList", 0)
	gosub Nounify %FestGivePoltuItems.itemToGet
	var FestGivePoltuItems.itemToGet %Nounify.noun
	gosub Get %FestGivePoltuItems.itemToGet from my woven sack
	gosub FestTrashOrKeep left
	gosub ClearHand left
	gosub Look in my woven sack
	if ("%Look.contents" != "null") then goto FestGivePoltuItemsGetItem
	gosub Trash my woven sack
	gosub ClearHand both
	if (%FestTrashOrKeep.saved == 1) then {
		# If we have a prize, then...
		if ("%FestGivePoltuItems.itemToGet" != "deed") then {
			# If the prize wasn't a deed, turn it into a deed:
			gosub Get my deed packet
			if (%Get.success == 0) then {
				gosub Wealth
				if (%Wealth.dokoras < 22550) then {
					# Todo: a BuyItem gosub that would auto-withdraw coins as needed.
					gosub Navigate 150 teller
					gosub Withdraw 23 gold
				}
				gosub Navigate 150 deeds
				gosub Order 3
			}
			gosub Get my %FestGivePoltuItems.itemToGet
			gosub Push my %FestGivePoltuItems.itemToGet with my deed packet
			gosub ClearHand both
		}
	}
	return

FestGivePoltuItemsFindPoltu:
	if ("%FestGivePoltuItems.poltuDirection" != "" && "" !contains("%FestGivePoltuItems.poltuDirection", "%")) then gosub Move %FestGivePoltuItems.poltuDirection
	if (contains("$roomobjs", "Poltu")) then goto FestTurninItemsFoundPoltu
	if (%FestGivePoltuItems.lastPoltuRoom > 0) then gosub Navigate 210 %FestGivePoltuItems.lastPoltuRoom
	if (contains("$roomobjs", "Poltu")) then goto FestTurninItemsFoundPoltu
	if (!contains("$roomobjs", "Poltu")) then {
		gosub RunScripts FestSearchFor Poltu
	}
FestTurninItemsFoundPoltu:
	var FestGivePoltuItems.poltuDirection 
	var FestGivePoltuItems.lastPoltuRoom $roomid
	return