#REQUIRE Send.cmd

gosub Connect %0
exit

Connect:
	var Connect.string $0
	var Connect.success 0
Connecting:
	# Note: can't actually match the failure strings, unfortunately. Keeping them in anyway because timeout works fine also.
	gosub Send Q "#connect %Connect.string" "^All Rights Reserved$" "^Access rejected\.$|^Profile.*not found\.$"
	var Connect.success %Send.success
	if (%Connect.success == 1) then return
	pause 15
	goto Connecting