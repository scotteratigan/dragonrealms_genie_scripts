#REQUIRE ClearHand.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Send.cmd

gosub Pound %0
exit

Pound:
	var Pound.command $0
	var Pound.success 0
	if ("$righthandnoun" != "hammer") then {
		gosub ClearHand right
		gosub Get my hammer
		if ("$righthandnoun" != "hammer") then {
			gosub Error Couldn't find forging hammer, aborting.
			return
		}
	}
	if (!matchre("$lefthand", ".* tongs$")) then {
		gosub ClearHand left
		gosub Get my tongs
		if (!matchre("$lefthand", ".* tongs$")) then {
			gosub Error Couldn't find tongs, aborting.
			return
		}
	}
Pounding:
	gosub Send RT "pound %Pound.command" "^After using the tongs to warm .+ over the forge fire,.*$|^Following solid heating in the forge, you carefully fold.*$|^Sparks fly into the air as you transfer .+ back and forth.*$|^You scoop up .+ with your tongs and heat it.*$" "^You cannot figure out how to do that\.  Perhaps finding suitable ingredients and studying some instructions would help\.$|^That tool does not seem suitable for that task\.$|^The fire needs more fuel before you can do that\.$|^A cooler fire could impede forging, but you ignore it and go on\..*$|^The cooling forge fire appears to cause problems with heating.*$|^Despite the metal's need for some gentle working you keep hammering.*$" "WARNING MESSAGES"
	var Pound.response %Send.response
	if ("%Send.success" == "1") then {
		var Pound.success 1
		return
	}
	return