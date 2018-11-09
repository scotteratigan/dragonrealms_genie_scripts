gosub Information %0
exit

Information:
	var Info.message $0 ($gametime) [$zoneid - $roomid]
	if ("$righthand" == "Empty" && "$lefthand" == "Empty") then {
		var Info.message %Info.message nothing in hands
	}
	else {
		var Info.message %Info.message (L $lefthand #$lefthandid|R $righthand #$righthandid)
	}
	# Display the Info in the game log window:
	put #echo >ScriptLog white Info: %scriptname.cmd %Info.message
	# Save to log file to allow review later. Very useful with $gametime because it is a unique search string:
	put #log Info: %scriptname.cmd %Info.message
	# Optional parse to trigger off of specific Info messages:
	# Disabled for performance as well as interference with Read.cmd:
	#put #parse Info: %scriptname.cmd %Info.message
	return