gosub ERROR %0
exit

ERROR:
	var ERROR.message $0 ($gametime) [$zoneid - $roomid]
	if ("$righthand" == "Empty" && "$lefthand" == "Empty") then {
		var ERROR.message %ERROR.message nothing in hands
	}
	else {
		var ERROR.message %ERROR.message (L $lefthand #$lefthandid|R $righthand #$righthandid)
	}
	# Display the error in the game log window:
	put #echo >Log yellow Error: %ERROR.message
	# Save to log file to allow review later. Very useful with $gametime because it is a unique search string:
	put #log Error: %ERROR.message
	# Optional parse to trigger off of specific error messages:
	put #parse Error: %ERROR.message
	# Note: no beeping/flashing here - left up to user to configure via global trigger.
	put #echo Error: %ERROR.message
	return