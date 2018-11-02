#REQUIRE Perceive.cmd

# Note: this is not a real command, it's really an alias for Perceive.
# However, it exists and can be used, so I've replicated the functionality here. See also, concentrate.

gosub Power %0
exit

Power:
	var Power.option $0
	var Power.success 0
	gosub Perceive %Power.option
	if ("%Power.success" == "1") then var Power.success 1
	return