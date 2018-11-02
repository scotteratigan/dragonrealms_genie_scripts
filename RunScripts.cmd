# RunScripts will run a list of scripts, in array format. It will wait for the detection of a script to start, and then for the script to complete, before moving onto the next script.
# There is a chance for missed detection on short scripts which send no commands and execute in less than .01 seconds. In this case, a pause would need to be added to the script you are executing.
# Usage:
# .RunScripts south|southeast|go bank
# .RunScripts prepare ease 20|waitspelltime 15|cast
# Also, you can run a script multiple times with the following syntax:
# .RunScripts north|5east|2south

gosub RunScripts %0
exit

RunScripts:
	eval RunScripts.scriptArray tolower("$0")
	if ("%RunScripts.scriptArray" == "") then {
		gosub Error RunScripts called with no scripts specified!
		return
	}
	eval RunScripts.maxIndex count("%RunScripts.scriptArray", "|")
	var RunScripts.index 0
RunningScripts:
	eval RunScripts.currentScriptName element("%RunScripts.scriptArray", %RunScripts.index)
	var RunScripts.executionMax 1
	var RunScripts.exectionCount 0
	if (matchre("%RunScripts.currentScriptName", "^(\d+)")) then {
		var RunScripts.executionMax $1
		eval RunScripts.currentScriptName replacere("%RunScripts.currentScriptName", "^\d+", "")
	}
RunningScriptsExecuteNow:
	put .%RunScripts.currentScriptName
	#waitforre ^SCRIPT STARTED: %RunScripts.currentScriptName
	waiteval (contains("|$scriptlist|", "|%RunScripts.currentScriptName.cmd|"))
	waiteval (!contains("|$scriptlist|", "|%RunScripts.currentScriptName.cmd|"))
	math RunScripts.exectionCount add 1
	if (%RunScripts.exectionCount < %RunScripts.executionMax) then goto RunningScriptsExecuteNow
	math RunScripts.index add 1
	if (%RunScripts.index <= %RunScripts.maxIndex) then goto RunningScripts
	return
