#REQUIRE Arrayify.cmd
#REQUIRE Read.cmd
#REQUIRE Send.cmd
#REQUIRE Open.cmd

gosub Look %0
exit

# Look.contents - list of items with commas
# Look.contentsList - array of items you looked at: some copper coins|some bronze coins
# Look.containerArea - in|on|under
# Look.contentsFullyListed - boolean, true if "and a lot of other stuff"
# Look.exits - room exits: You also see "(.+)"

Look:
	var Look.target $0
	var Look.attemptedToOpen 0
	var Look.containerName null
	var Look.contents null
	var Look.contentsList null
	var Look.contentsCount -1
	var Look.contentsFullyListed 1
	action var Look.containerArea $1;var Look.containerName $2;var Look.contents $3 when ^(In|On|Under) the (.+) you see (.+)\.$
	action var Look.contentsCount 0 when ^There is nothing (in|on|under) there\.$
	action var Look.contentsFullyListed 0 when ^In the .+ you see .* a lot of other stuff\.$
	# Look.exits is for looking in rooms where $roomexits variable doesn't set properly, like in the Crossing Temple:
	action var Look.exits $2;if ("%Look.exits" == "none") then var Look.exits null when ^(Obvious exits|Obvious paths|Ship paths): (.+)\.$
	action var Look.poleBaited 0 when ^The pole isn't baited\.$
	action var Look.poleBaited 1 when ^The pole is baited with .*\.$
Looking:
	gosub Send Q "look %Look.target" "^(In|On|Under) the .+ you see .+\.$|^There is nothing (in|on|under) there\.$|^Obvious (paths|exits):|^Ship paths:|^It's pitch dark.*$|^The anvil's surface looks clean and ready for forging\.$|^You see nothing unusual\.$|^It's a.*fishing pole .*$" "^That is closed\.$" "^There appears to be something written on it\."
	var Look.response %Send.response
	action remove ^(In|On|Under) the (.+) you see (.+)\.$
	action remove ^There is nothing (in|on|under) there\.$
	action remove ^(Obvious exits|Obvious paths|Ship paths): (.+)\.$
	action remove ^The pole isn't baited\.$
	action remove ^The pole is baited with .*\.$
	if ("%Look.response" == "That is closed." && !Look.attemptedToOpen) then {
		gosub Open %Look.target
		var Look.attemptedToOpen 1
		goto Looking
	}
	if ("%look.response" == "There appears to be something written on it.") then {
		gosub Read %Look.target
		return
	}
	if ("%Look.contents" == "null") then {
		var Look.contentsFullyListed -1
	}
	if ("%Look.contents" != "null") then {
		gosub Arrayify %Look.contents
		var Look.contentsList %Arrayify.list
		eval Look.contentsCount count("%Look.contentsList", "|")
		math Look.contentsCount add 1
		echo Look.contents %Look.contents
	}
	if ("%Look.exits" != "null") then {
		gosub Arrayify %Look.exits
		var Look.exitList %Arrayify.list
	}
	return

# Todo: set other player look into variable?
#You see Weapon Master Timbits, a Human Barbarian.
#Timbits has a round face, limpid leaf-green eyes and a small nose.  His blonde hair is shoulder length and thick.  He has wrinkled skin and a stout build.
#He is a bit over average height for a Human.
#He appears to be an adult.
#He has a thick bushy mustache that droops heavily on his upper lip and a long shaggy beard.
#He is in good shape.
#He is holding some yelith root in his right hand.
#He is wearing a battered and bloody haversack sewn from the dirty skins of board trolls, a lumium bascinet, some lumium scale gloves, a lumium scale aventail, some lumium ring greaves, a padded heavy titanese shirt with fitted seams, a storm-bull targe sealed with protective wax, an ornate niello ring, a shiny megaphone emblazoned with "Two Bits! Four Bits! Six Bits! A Dollar!", a pair of delicately etched moonsilver zills edged with inkdrop agates, a purple gem pouch, a lopsided chakrel rock hanging from a silversteel nose ring, a sanowret crystal, a duffel bag, a studded toolstrap with black jasper beading, a wide leather toolstrap with braided cord ties, a belted kidskin baldric tooled with sinuous maiden's tress vines, a lockpick ring, a solid orange backpack with a dingy blue patch, a thigh quiver dyed in a brown and green camouflage pattern, a thick leather scroll case adorned with golden symbols, a jagged obsidian-bladed ankle knife, a book of master crafting instructions and a human skull hanging from a piece of twine.