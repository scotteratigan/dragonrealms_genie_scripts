#REQUIRE Cast.cmd
#REQUIRE ClearHand.cmd
#REQUIRE EnsureHands.cmd
#REQUIRE GetBait.cmd
#REQUIRE Look.cmd
#REQUIRE Nounify.cmd
#REQUIRE Pull.cmd
#REQUIRE Waitforre.cmd

# Todo: what is text match for an empty bait box?

gosub Fish
exit

Fish:
	var Fish.success 0
	gosub EnsureHands fishing pole
	if (%EnsureHands.success == 0) then return
	gosub Look at my fishing pole
	if (%Look.poleBaited != 1) then gosub GetBait my white box
	if (%GetBait.success == 0) then return
	gosub Cast my fishing pole
	if (%Cast.success == 0) then return
	gosub Waitforre 15 ^You feel a very slight, irregular tremor on your fishing pole\.$|^You feel a slight tug on your fishing pole\.$|^You feel a definite tug on your fishing pole\.$|^You feel a hard tug on your fishing pole\.$
	gosub Pull my fishing pole
	if ("$lefthand" == "Empty") then goto Fish
	gosub ClearHand left
	var Fish.success 1
	return