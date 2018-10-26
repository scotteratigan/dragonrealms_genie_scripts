#REQUIRE Advance.cmd
#REQUIRE Send.cmd
gosub Analyze %0
exit

Analyze:
	eval Analyze.option tolower("$0")
	var Analyze.tooMuchAnalysis 0
	action var Analyze.tooMuchAnalysis 1 when ^Your analysis reveals a massive opening already being exploited in .+'s defenses\.$
Analyzing:
	gosub Send RT "analyze %Analyze.option" "^Your analysis reveals|^You reveal a .+ weakness" "^Analyze what\?$" "^You fail to find any holes in the .+'s defenses\.$|^You must be closer to use tactical abilities on your opponent\.$"
	if ("%Send.response" == "You must be closer to use tactical abilities on your opponent.") then {
		gosub AdvancePole
		goto Analyzing
	}
	if (matchre("%Send.response", "^You fail to find any holes in the .+'s defenses\.$")) then goto Analyzing
	return
