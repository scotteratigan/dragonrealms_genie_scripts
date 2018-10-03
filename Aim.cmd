#REQUIRE Block.cmd
#REQUIRE Send.cmd

gosub AIM %0
exit

AIM:
	var AIM.option $0
	gosub Send Q "aim %AIM.option" "^You begin to target|^You shift your target|^You are already targetting that\!$" "^Your .+ isn't loaded\!$|^What are you trying to attack\?|^But the .+ in your right hand isn't a ranged weapon\!$|^You are unable to aim at .+ because you cannot face it\.$"
	if (matchre("SEND.message", "^You are unable to aim at .+ because you cannot face it\.$")) then {
		gosub BLOCK stop
	}
	return

#>aim kelp
#You are too closely engaged and will have to retreat first.
#You are unable to aim at the kelpie because you cannot face it.