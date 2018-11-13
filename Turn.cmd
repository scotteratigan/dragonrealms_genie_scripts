#REQUIRE Send.cmd

gosub Turn %0
exit

Turn:
	var Turn.command $0
	var Turn.success 0
Turning:
	action var Turn.grindstoneSpinningFast 1 when ^Straining a bit less you add force to the grindstone, making it spin even faster\.$|^Straining a bit less you maintain force to the grindstone, keeping it spinning fast\.$
	var Turn.grindstoneSpinningFast 0
	gosub Send Q "turn %Turn.command" "^You turn .+ to.*$|^Grabbing the handle you strain to turn the grindstone\.$|^You lay .+ down parallel to the anvil's horn and notice it has become crooked\. Turning it about, you gently tap it back to the correct straightness\.$|^You lay the .+ down parallel to the anvil's horn and notice it has become crooked\. Turning it about, you gently tap it back into the correct form\.$|^You angle the .+ downward along the anvil's horn with your tongs, and then gently tap it with your hammer\.$|^You hold the .+ steady on the horn of the anvil with your tongs\.  Then you tap it lightly with your hammer to add a curve along the metal's surface\.$" "^A .+ does not have a chapter .+\.$|^This chapter does not have that many pages\.$|^Where do you wish to turn .+ to\?$" "^The book is already turned to.*$"
	pause .01
	action remove ^Straining a bit less you add force to the grindstone, making it spin even faster\.$|^Straining a bit less you maintain force to the grindstone, keeping it spinning fast\.$
	var Turn.response %Send.response
	if ("%Turn.response" == "Grabbing the handle you strain to turn the grindstone.") then {
		if (%Turn.grindstoneSpinningFast == 0) then goto Turning
	}
	if ("%Send.success" == "1") then {
		var Turn.success 1
		return
	}
	return

# to add:
# The muracite tongs is far too damaged to be used for that.