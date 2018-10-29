#REQUIRE Send.cmd
#REQUIRE Warning.cmd

gosub Hide %0
exit

Hide:
	var Hide.option $0
	var Hide.success 0
Hiding:
	if ($hidden == 1) then {
		gosub Warn Hide - Tried to hide when already hidden!
		return
	}
	gosub Send RT "hide %Hide.option" "^You melt into the background, .*$|^You blend in with your surroundings.*$|^Eh?  But you're already hidden\!$" "^You look around, but can't see any place to hide yourself\.$|^You look around for a dark corner to get lost in.*$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Hide.success 1
	return

