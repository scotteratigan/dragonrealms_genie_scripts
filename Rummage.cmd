#REQUIRE Arrayify.cmd
#REQUIRE NounifyList.cmd
#REQUIRE Open.cmd
#REQUIRE Send.cmd
#REQUIRE Uninvisible.cmd
#REQUIRE Warning.cmd

# Will auto-leave invisibility to rummage, and will open closed containers if possible.
# Results are saved in variables:
# Rummage.text "a scimitar, a goblin skin, and a rock"
# Rummage.list "a scimitar|a goblin skin|a rock"
# Rummage.nounList "scimitar|skin|rock"

#Rummage.type options:
# /a - armor
# /am - ammunition
# /b - boxes
# /f - fish
# /g - gems
# /h - healing herbs and potions
# /s - hides, skins and bones
# /w - weapons
# /m - crafting materials
# /c - custom (also sets Rummage.customType to the search term)

gosub Rummage %0
exit

Rummage:
	#debuglevel 10
	eval Rummage.target tolower("$0")
	var Rummage.success 0
	var Rummage.retried 0
	var Rummage.type null
	var Rummage.customType null
	var Rummage.container null
	var Rummage.list null
	var Rummage.nounList null
	var Rummage.text null
	action var Rummage.container $1;var Rummage.type $2;var Rummage.text $3 when ^You rummage through (.+) looking for (.+) and see (.+)\.$
	action var Rummage.container $1;var Rummage.type custom;var Rummage.customType $2;var Rummage.text $3 when ^You rummage through (.+) looking for something similar to "(.+)" and see (.+)\.$
	# You rummage through a smoke grey leather backpack looking for something similar to "blah" but there is nothing in there like that.
	# You rummage through a smoke grey leather backpack looking for fish but there is nothing in there like that.
Rummaging:
	if ($invisible == 1) then gosub Uninvisible
	gosub Send Q "rummage %Rummage.target" "^You rummage" "^You feel about|^While it's closed\?$" "WARNING MESSAGES"
	if ("%Send.response" == "You feel about" && %Rummage.retried == 0) then {
		gosub Warning Tried to rummage after invisibility pulsed, retrying...
		var Rummage.retried 1
		goto Rummaging
	}
	if ("%Send.response" == "While it's closed?") then {
		gosub Warning Tried to rummage a closed container, will attempt to open first.
		# First deal with a custom arrange:
		eval Rummage.container replacere("%Rummage.target", "/c \S+", "")
		# Then deal with rummage type (/w for weapons, for example):
		eval Rummage.container replacere("%Rummage.container", "/\S+ ", "")
		# Last, deal with location modifiers:
		eval Rummage.container replacere("%Rummage.container", "^\s+(in|on|under|behind) ", "")
		gosub Open %Rummage.container
		if ("%Open.success" == "1") then goto Rummaging
	}
	if ("%Send.success" == "1") then var Rummage.success 1
	action remove ^You rummage through (.+) looking for armor and see (.+)\.$
	action remove ^You rummage through (.+) looking for something similar to "(.+)" and see (.+)\.$
	if ("%Rummage.text" != "null") then {
		gosub Arrayify %Rummage.text
		var Rummage.list %Arrayify.list
		gosub NounifyList %Rummage.list
		var Rummage.nounList %NounifyList.list
		echo Rummage.nounList is %Rummage.nounList
	}
	return
