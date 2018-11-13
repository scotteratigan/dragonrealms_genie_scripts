#REQUIRE Advance.cmd
#REQUIRE Send.cmd
gosub Analyze %0
exit

Analyze:
	eval Analyze.option tolower("$0")
	var Analyze.tooMuchAnalysis 0
	action var Analyze.damageLevel $2 when ^This appears to be a crafting tool and (it|they) (.+)\.$
	action var Analyze.tooMuchAnalysis 1 when ^Your analysis reveals a massive opening already being exploited in .+'s defenses\.$
Analyzing:
	gosub Send RT "analyze %Analyze.option" "^You analyze every minute detail of.+$|^Your analysis reveals|^You reveal a .+ weakness" "^Analyze what\?$" "^You fail to find any holes in the .+'s defenses\.$|^You must be closer to use tactical abilities on your opponent\.$"
	pause .01
	action remove ^This appears to be a crafting tool and (it|they) (.+)\.$
	action remove ^Your analysis reveals a massive opening already being exploited in .+'s defenses\.$
	if ("%Send.response" == "You must be closer to use tactical abilities on your opponent.") then {
		gosub AdvancePole
		goto Analyzing
	}
	if (matchre("%Send.response", "^You fail to find any holes in the .+'s defenses\.$")) then goto Analyzing
	return

#> anal my hammer
# You analyze every minute detail of the ball-peen hammer and smile knowingly to yourself.
# This appears to be a crafting tool and it has some minor scratches.
# This reinforced hammer is used to pound heated metal into shape on an anvil.
# The workmanship is masterfully-crafted.
# Assessing the hammer's durability, you determine it is extremely weak and easily damaged.
# About 12 volume of metal was used in this item's construction.
# The metal appears to be composed of: 100.00% high carbon steel.
# This tool appears to be exceptionally effective at increasing crafting speed.
# You recognize the maker's mark, and style of crafting enough to identify Rubinium as the item's creator.
# The metal appears to have been slowly tempered to improve its durability.
# Roundtime: 10 sec.

# This appears to be a crafting tool and they are battered and practically destroyed. <- may stop working at this stage
# This appears to be a crafting tool and it has some minor scratches.
# This appears to be a crafting tool and it is in good condition.
# This appears to be a crafting tool and it is practically in mint condition.