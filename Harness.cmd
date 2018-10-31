#REQUIRE Send.cmd

gosub Harness %0
exit

# Note: 200 is the max mana you can harness at once.

Harness:
	var Harness.command $0
	var Harness.success 0
	if (matchre("%Harness.command", "^\s*(\d+)")) then var Harness.mana $1
	else var Harness.mana 0
Harnessing:
	gosub Send RT "harness %Harness.command" "^You tap into the mana" "^Strain though you may, you are unable to harness and localize this much energy around yourself\.$|^You reconsider attempting to harness this much energy around yourself at once\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Harness.success 1
	return

# You tap into the mana from two of the surrounding streams and attempt to keep it channeling in a stream around you.
# You tap into the mana from two of the surrounding streams and add it to the little amount already streaming around you.

# Todo: ensure all matches work with harness quiet/warn/and verbose
#  HARNESS....................see your harness information
#  HARNESS QUIET..............no harness messaging when preparing a spell (default)
#  HARNESS WARN...............only warn if a spell might use up most of your harness
#  HARNESS VERBOSE............always see harness messaging when preparing a spell

# > harness
# You are Wizard-like in your ability at harnessing mana.
# You currently have a complete attunement to the streams of mana.
# You are holding no mana in localized streams around you.
# Attunement: [0%>>>>>>>>>>>>>>>>>>>>>>>>50%>>>>>>>>>>>>>>>>>>>>>>>100%] 
# You are receiving full harness messages (HARNESS VERBOSE is set).

# > harness
# You are Wizard-like in your ability at harnessing mana.
# You currently have a complete attunement to the streams of mana.
# You are holding no mana in localized streams around you.
# You are receiving no harness messages (HARNESS QUIET is set).