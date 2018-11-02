#REQUIRE Perceive.cmd

# Note: this is not a real command, it's really an alias for Perceive.
# However, it exists and can be used, so I've replicated the functionality here. See also, power.

gosub Concentrate %0
exit

Concentrate:
	var Concentrate.option $0
	var Concentrate.success 0
	gosub Perceive %Concentrate.option
	if ("%Concentrate.success" == "1") then var Concentrate.success 1
	return