#REQUIRE Send.cmd
#REQUIRE Release.cmd

gosub Prepare %0
exit

# Todo: add more spell preps

Prepare:
	var Prepare.command $0
	var Prepare.success 0
	var Prepare.strings You mutter incoherently to yourself while preparing|You raise your arms skyward, chanting|You raise your palms skyward, chanting|You hastily shout the arcane phrasings needed|With great force, you slap your hands together before you and slowly pull them apart,
Preparing:
	gosub Send Q "prepare %Prepare.command" "^%Prepare.strings.*$|^You play with the dead pattern in your mind, assessing your current state\.$" "^You have no idea how to cast that spell\.$|^You are already preparing the .+ spell\!$|^Prepare a spell by name or abbreviation followed by a numerical amount.*$|^Something in the area interferes with your spell preparations\.$" "WARNING MESSAGES"
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

# > prepare sre
# You play with the dead pattern in your mind, assessing your current state.
# The power of your next rebirth will be enough to both resuscitate you and knit your wounds closed.
# You have as much power as your state of being and knowledge of Thanatology allows.