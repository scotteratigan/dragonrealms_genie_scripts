#REQUIRE Send.cmd

gosub Load %0
exit

Load:
	var Load.option $0
Loading:
	gosub Send RT "load %Load.option" "^Roundtime \d+ sec\.$" "^You can't load .+, silly\!$"
	# todo: add checks for no ammo, etc.
	return