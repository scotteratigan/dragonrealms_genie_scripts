#REQUIRE Send.cmd

gosub Cast %0
exit

# Note: this does not match the ^You gesture string that most scripts do, because that doesn't indicate success or failure.

# Todo: add more spells. Currently only supports:
# Devour

Cast:
	var Cast.target $0
	var Cast.success 0
	var Cast.devourSuccess ^A wave of feverish heat settles into your flesh, the momentary surge of agony subsiding slowly into an aching feeling of heightened sensation\.$
	var Cast.devourFailure ^Lacking any ritually prepared corpses or material, the spell pattern fails entirely\.$
	var Cast.siphonVitalitySuccess ^With a slight flick, you point one of your fingers at .+\.$
	var Cast.acidSplashSuccess ^You cup your hand before thrusting your palm up and out in a slapping motion at .+\!$
Casting:
	gosub Send RT "cast %Cast.target" "%Cast.devourSuccess|%Cast.siphonVitalitySuccess|%Cast.acidSplashSuccess" "^Currently lacking the skill to complete the pattern, your spell fails completely\.$|^You strain, but are too mentally fatigued to finish the pattern, and it slips away\.$|^You can't cast that at yourself\!$|^You don't have a spell prepared\!$|%Cast.devourFailure" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Cast.success 1
	return