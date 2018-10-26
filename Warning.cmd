gosub Warning %0
exit

Warning:
	var Warning.message $0 ($gametime) [$zoneid - $roomid]
	if ("$righthand" == "Empty" && "$lefthand" == "Empty") then {
		var Warning.message %Warning.message nothing in hands
	}
	else {
		var Warning.message %Warning.message (L $lefthand #$lefthandid|R $righthand #$righthandid)
	}
	# Display the Warning in the game log window:
	put #echo >Log yellow Warning: %scriptname.cmd %Warning.message
	# Save to log file to allow review later. Very useful with $gametime because it is a unique search string:
	put #log Warning: %scriptname.cmd %Warning.message
	# Optional parse to trigger off of specific Warning messages:
	put #parse Warning: %scriptname.cmd %Warning.message
	# Note: no beeping/flashing here - left up to user to configure via global trigger.
	return