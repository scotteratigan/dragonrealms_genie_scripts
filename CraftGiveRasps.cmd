#REQUIRE ClearHand.cmd
#REQUIRE Drop.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Nod.cmd
#REQUIRE Put.cmd

action put #script pause craftmakeunfinishedrasps;put #script pause fynmenger;put #script pause copernicus;goto CraftGiveRaspsHandoff when ^Rellie nods to you\.$

CraftGiveRasps:
waitforre ^ZZ$


CraftGiveRaspsHandoff:
var CraftGiveRasps.itemToRetrieve null
# Pause and stand gosub are to prevent the rare timing event that you finish crafting an item just as Rellie comes in and nods.
# By adding this pause first, we ensure that both scripts don't try to clear a hand at the same time.
pause 2
gosub Stand
if ("$lefthand" != "Empty") then {
	var CraftGiveRasps.itemToRetrieve #$lefthandid
	gosub ClearHand left
	if (%ClearHand.success == 0) then {
		gosub Put #$lefthandid in my bag
		if (%Put.success == 0) then exit
	}
}
CraftGivingRasps:
	gosub Get my rasp
	if (%Get.success == 0) then {
		gosub Nod Rellie
		goto CraftGiveRaspsResume
	}
	gosub Drop my rasp
	goto CraftGivingRasps

CraftGiveRaspsResume:
	gosub ClearHand left
	if ("%CraftGiveRasps.itemToRetrieve" != "null") then gosub Get %CraftGiveRasps.itemToRetrieve
	pause
	put #script resume craftmakeunfinishedrasps
	put #script resume fynmenger
	put #script resume copernicus
	goto CraftGiveRasps