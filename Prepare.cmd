#REQUIRE Send.cmd
#REQUIRE Release.cmd

gosub Prepare %0
exit

# Todo: add more spell preps

Prepare:
	var Prepare.command $0
	var Prepare.success 0
	var Prepare.strings You mutter incoherently to yourself while preparing|You raise your arms skyward, chanting|^You raise your palms skyward, chanting
Preparing:
	gosub Send Q "prepare %Prepare.command" "^%Prepare.strings.*$" "^You have no idea how to cast that spell\.$|^You are already preparing the .+ spell\!$|^Prepare a spell by name or abbreviation followed by a numerical amount.*$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then {
		var Prepare.success 1
		return
	}
	if (matchre("%Send.response", "^You alre already preparing")) then {
		gosub Release spell
		goto Preparing
	}
	return

#Todo: add Prepare.attunementEstimate vars:
#That won't affect your current attunement very much.
#That will disrupt less than a quarter of your current attunement.
#That will disrupt less than half your current attunement.
#That will disrupt most of your current attunement!
#You feel intense strain as you try to manipulate the mana streams to form this pattern, and you are not certain that you will have enough mental stamina to complete it.
