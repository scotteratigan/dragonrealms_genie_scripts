gosub Error %0
exit

Error:
	var Error.message $0 ($gametime) [$zoneid - $roomid]
	if ("$righthand" == "Empty" && "$lefthand" == "Empty") then {
		var Error.message %Error.message nothing in hands
	}
	else {
		var Error.message %Error.message (L $lefthand #$lefthandid|R $righthand #$righthandid)
	}
	# Display the error in the game log window:
	put #echo >Log yellow Error: %Error.message
	# Save to log file to allow review later. Very useful with $gametime because it is a unique search string:
	put #log Error: %Error.message
	# Optional parse to trigger off of specific error messages:
	put #parse Error: %Error.message
	# Note: no beeping/flashing here - left up to user to configure via global trigger.
	put #echo Error: %Error.message
	return