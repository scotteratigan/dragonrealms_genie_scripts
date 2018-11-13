

# Purpose: launch specified script after another script completes.
# See also: RunScripts.cmd

# Example: gosub/.AfterScript craftrepairfangcove|copernicus

gosub AfterScript %0
exit

AfterScript:
	var AfterScript.input $0
	eval AfterScript.waitScript element("%AfterScript.input", 0)
	eval AfterScript.runScript element("%AfterScript.input", 1)
	echo Will run %AfterScript.runScript once %AfterScript.waitScript completes.
	eval AfterScript.waitScriptString tolower("%AfterScript.waitScript")
	if (!matchre("%AfterScript.waitScriptString", "\.cmd$")) then var AfterScript.waitScriptString %AfterScript.waitScriptString.cmd
	echo Waiting on script %AfterScript.waitScriptString
AfterScriptWaiting:
	pause 2
	if (!contains("|$scriptlist|", "|%AfterScript.waitScriptString|")) then {
		pause .3
		if (!contains("|$scriptlist|", "|%AfterScript.waitScriptString|")) then {
			put .%AfterScript.runScript
			return
		}
	}
	goto AfterScriptWaiting