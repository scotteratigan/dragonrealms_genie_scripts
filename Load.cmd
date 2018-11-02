#REQUIRE Send.cmd

gosub Load %0
exit

Load:
	var Load.option $0
	var Load.success 0
Loading:
	gosub Send RT "load %Load.option" "^You reach into your .+ to load.*$|^You load the .+ with .+ in your hand\.$|^You carefully load your.*$" "^You can't load .+, silly\!$|^You need to hold .+ in your right hand to load it\.$|^What weapon are you trying to load\?$" "^Your .+ is already loaded with .+\.$"
	if (%Send.success == 1) then {
		var Load.success 1
		return
	}
	return