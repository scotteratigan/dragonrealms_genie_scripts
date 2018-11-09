#REQUIRE Send.cmd

gosub Remove %0
exit

Remove:
	var Remove.item $0
	var Remove.success 0
Removing:
	gosub Send RT "remove %Remove.item" "^You remove|^You take .+ off|^You loosen the straps securing|^You pull off|^You pull your .+ off|^You sling .+ off|^You slide .+ off|^You pull off|^You work your way out of|^You detach|^A brisk chill leaves you as you remove.*$" "^You aren't wearing that\.$|^Remove what\?$|^You need a free hand for that\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Remove.success 1
	return