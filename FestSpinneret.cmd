#REQUIRE Appraise.cmd
#REQUIRE Navigate.cmd
#REQUIRE NavigateRoomName.cmd
#REQUIRE Pinch.cmd
#REQUIRE Poke.cmd
#REQUIRE Prod.cmd
#REQUIRE Pull.cmd
#REQUIRE Push.cmd
#REQUIRE Get.cmd
#REQUIRE FestTrashOrKeep.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE ClearHand.cmd
#REQUIRE WaitWebbed.cmd

gosub FestSpinneret
exit

FestSpinneret:
	if ("$SpellTimer.Devour.active" != "1") then gosub FestCastDevour
	gosub NavigateRoomName 210 spinneret The Baby Metal Arachnid, Spinneret
	gosub Push button
	if (%Push.success == 0) then return
	var FestSpinneret.bestOdds 0
	action var FestSpinneret.bestOdds 1 when ^You're pretty sure you've improved your odds as much as you possibly can\.$
FestSpinneretting:
	gosub Appraise spinneret
	if (matchre("%Appraise.response", "^You think you can (\S+) the (\S+) to increase your chances of spinning a good fabric\.$")) then gosub $1 $2
	if (%FestSpinneret.bestOdds != 1) then goto FestSpinneretting
	action remove ^You're pretty sure you've improved your odds as much as you possibly can\.$
	gosub Pull lever
	if ("$righthand" != "Empty") then {
		gosub FestTrashOrKeep right
		if (%FestTrashOrKeep.saved == 1) then {
			gosub Get my deed packet
			gosub Push #$righthandid with #$lefthandid
			gosub ClearHand both
		}
	}
	gosub WaitWebbed
	return


# > push button
# You count out 1000 Dokoras and drop the coins into a slot in the side of the spinneret where they vanish with a rattle.  You then push a button on one of the panels, and something in the spinneret starts whirring.
# You think you can mess with the gizmo, slider, dial, prong, and gadget to up your chances of getting a good item.
# You also think you might be able to appraise the spinneret to see what to do next.

# You prod at the gizmo, and it makes a whirring noise.
# You think your messing with the metal gizmo has improved your odds of spinning a good fabric.
# Roundtime: 5 Sec.

# You pull the lever, and a *chunka chunka chunka* noise comes from the spinneret as it starts to shake!
# After a moment, the panel opens up entirely, revealing...
# A big tangled snarl of thread!  It flies out of the spinneret, and straight at your face!  You are webbed!
# W> 
# ... 20ish seconds pass
# You finally manage to free yourself from the webbing.