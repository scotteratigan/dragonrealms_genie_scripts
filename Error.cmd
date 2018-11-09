gosub Error %0
exit

Error:
	# todo: include the last command in error message?
	var Error.message $0 ($gametime) [$zoneid - $roomid]
	if ("$righthand" == "Empty" && "$lefthand" == "Empty") then {
		var Error.message %Error.message nothing in hands
	}
	else {
		var Error.message %Error.message (L $lefthand #$lefthandid|R $righthand #$righthandid)
	}
	# Display the error in the game log window:
	put #echo >ScriptLog red Error: %scriptname.cmd %Error.message
	# Save to log file to allow review later. Very useful with $gametime because it is a unique search string:
	put #log Error: %scriptname.cmd %Error.message
	# Optional parse to trigger off of specific error messages:
	put #parse Error: %scriptname.cmd %Error.message
	# Note: no beeping/flashing here - left up to user to configure via global trigger.
	put #echo Error: %scriptname.cmd %Error.message
	return