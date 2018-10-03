#REQUIRE Send.cmd

gosub LOAD %0
exit

LOAD:
	var LOAD.option $0
LOADING:
	gosub Send RT "load %LOAD.option" "^Roundtime \d+ sec\.$" "^You can't load .+, silly\!$"
	# todo: add checks for no ammo, etc.
	return