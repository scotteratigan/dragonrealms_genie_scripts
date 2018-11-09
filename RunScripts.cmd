# RunScripts will run a list of scripts, in array format. It will wait for the detection of a script to start, and then for the script to complete, before moving onto the next script.
# There is a chance for missed detection on short scripts which send no commands and execute in less than .01 seconds. In this case, a pause would need to be added to the script you are executing.
# Usage:
# .RunScripts south|southeast|go bank
# .RunScripts prepare ease 20|waitspelltime 15|cast
# Also, you can run a script multiple times with the following syntax:
# .RunScripts north|5east|2south
# ALSO, you can run the entire script chain multiple times by prefixing the entire string with a number:
# .RunScripts 3 hide|steal water in vat|steal water in vat|trash my water|trash my water

gosub RunScripts %0
exit

RunScripts:
	# Don't convert case now because that prevents uppercase in script arguments.
	# This limits script functionality. For example .festsearchfor Poltu won't work.
	#eval RunScripts.scriptArray tolower("$0")
	var RunScripts.scriptArray $0
	var RunScripts.maxLoops 1
	if ("%RunScripts.scriptArray" == "") then {
		gosub Error RunScripts called with no scripts specified!
		return
	}
	if (matchre("%RunScripts.scriptArray", "^\s*(\d+) ")) then {
		var RunScripts.maxLoops $1
		eval RunScripts.scriptArray replacere("%RunScripts.scriptArray", "^\s*\d+ ", "")
		echo Will loop %RunScripts.maxLoops times!
	}
	eval RunScripts.maxIndex count("%RunScripts.scriptArray", "|")
	var RunScripts.index 0
	var RunScripts.loopCount 0
RunningScripts:
	var RunScripts.executionMax 1
	var RunScripts.exectionCount 0
	var RunScripts.currentScriptArguments 
	eval RunScripts.currentScriptName element("%RunScripts.scriptArray", %RunScripts.index)
	if (matchre("%RunScripts.currentScriptName", "(\S+) (\w+.*)")) then {
		var RunScripts.currentScriptName $1
		var RunScripts.currentScriptArguments $2
	}
	if (matchre("%RunScripts.currentScriptName", "^(\d+)")) then {
		var RunScripts.executionMax $1
		eval RunScripts.currentScriptName replacere("%RunScripts.currentScriptName", "^\d+", "")
	}
	# Convert script name to lower case now because it'll be lower case in $scriptlist
	eval RunScripts.currentScriptName tolower("%RunScripts.currentScriptName")
RunningScriptsExecuteNow:
	put .%RunScripts.currentScriptName %RunScripts.currentScriptArguments
	#waitforre ^SCRIPT STARTED: %RunScripts.currentScriptName
	waiteval (contains("|$scriptlist|", "|%RunScripts.currentScriptName.cmd|"))
	waiteval (!contains("|$scriptlist|", "|%RunScripts.currentScriptName.cmd|"))
	math RunScripts.exectionCount add 1
	if (%RunScripts.exectionCount < %RunScripts.executionMax) then goto RunningScriptsExecuteNow
	math RunScripts.index add 1
	if (%RunScripts.index <= %RunScripts.maxIndex) then goto RunningScripts
	math RunScripts.loopCount add 1
	if (%RunScripts.loopCount < %RunScripts.maxLoops) then {
		var RunScripts.index 0
		goto RunningScripts
	}
	return
