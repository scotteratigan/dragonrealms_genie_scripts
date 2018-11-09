#REQUIRE Get.cmd
#REQUIRE Put.cmd
#REQUIRE Inventory.cmd
#REQUIRE ClearHand.cmd

# Usage: .Transfer my backpack to my haversack

gosub Transfer %0
exit

Transfer:
	var Transfer.arguments $0
	eval Transfer.origin replacere("%Transfer.arguments", " to .+", "")
	eval Transfer.destination replacere("%Transfer.arguments", ".+ to ", "")
	echo Transfer.origin: %Transfer.origin
	echo Transfer.destination: %Transfer.destination
	if (!contains("$lefthand $righthand", "Empty")) then {
		gosub ClearHand left
		if (!contains("$lefthand $righthand", "Empty")) then {
			gosub Error Couldn't free a hand to begin transfer.
			return
		}
	}
	# If we're here, assume we have a hand free:
	var Transfer.hand left
	if ("$righthand" == "Empty") then var Transfer.hand right
	gosub Inventory %Transfer.origin
	if ("%Inventory.text" == "") then {
		gosub Error No items seen in Transfer.origin %Transfer.origin
		return
	}
	gosub NounifyList %Inventory.text
	var Transfer.nounList %NounifyList.list
	var Transfer.index 0
	eval Transfer.maxIndex count("%Transfer.nounList", "|")
Transferring:
	eval Transfer.currentItem element("%Transfer.nounList", %Transfer.index)
	gosub Get %Transfer.currentItem from %Transfer.origin
	if (%Get.success == 1) then {
		if ("%Transfer.hand" == "right") then var Transfer.itemID #$righthandid
		if ("%Transfer.hand" == "left") then var Transfer.itemID #$lefthandid
		gosub Put %Transfer.itemID in %Transfer.destination
		if (%Put.success == 0) then {
			gosub Error Couldn't put item into destination container, putting back in origin container.
			gosub Put %Transfer.itemID in %Transfer.origin
		}
	}
	math Transfer.index add 1
	if (%Transfer.index <= %Transfer.maxIndex) then goto Transferring
	return