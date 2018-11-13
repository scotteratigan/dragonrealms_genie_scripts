#REQUIRE Stow.cmd

gosub StowAll %0
exit

StowAll:
	var StowAll.item $0
	var StowAll.success 0
	var StowAll.count 0
	# Success will be true if you stow even 1 item I guess...
StowAlling:
	gosub Stow %StowAll.item
	var StowAll.response %Send.response
	if (%Stow.success == 1) then {
		var StowAll.success 1
		math StowAll.count add 1
		goto StowAlling
	}
	echo Stowed: %StowAll.count of %StowAll.item
	return