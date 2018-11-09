#REQUIRE Send.cmd

gosub Wear %0
exit

Wear:
	var Wear.target $0
	var Wear.success 0
Wearing:
	gosub Send Q "wear %Wear.target" "^You attach|^You put .+ on|^You put on .+|^You put .+ around|^You slide your left arm through|^You slip .+ on|^You sling .+ over your shoulder|^You place|^You slip into|^You gently place|^You slide .+ on|^You drape .+ around|^You strap .+ along your right forearm,|^You work your way into|^You hang|^You strap|^You press .+ against your forehead|^You perch .+ on your shoulder\.$|^You carefully attach .+ to your wrist and tuck it out of sight\.$|^You carefully arrange .+ on your .+\.$|^A brisk chill rushes through you as you wear.*$" "^You are already wearing that\.|^Wear what\?|^You can't wear any more items like that\.|^You can't wear that\!$|^You should unload the|^You need to unload the" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Wear.success 1
	return