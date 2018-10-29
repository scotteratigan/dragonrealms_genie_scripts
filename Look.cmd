#REQUIRE Arrayify.cmd
#REQUIRE Send.cmd
#REQUIRE Open.cmd
gosub Look %0
exit

Look:
	var Look.target $0
	var Look.attemptedToOpen 0
	var Look.containerName null
	var Look.contents null
	var Look.contentsList null
	var Look.contentsCount -1
	var Look.contentsFullyListed 1
	action var Look.containerName $1;var Look.contents $2 when ^In the (.+) you see (.+)\.$
	action var Look.contentsCount 0 when ^There is nothing in there\.$
	action var Look.contentsFullyListed 0 when ^In the .+ you see .* a lot of other stuff\.$
	# Look.exits is for looking in rooms where $roomexits variable doesn't set properly, like in the Crossing Temple:
	action var Look.exits $2;if ("%Look.exits" == "none") then var Look.exits null when ^(Obvious exits|Obvious paths|Ship paths): (.+)\.$
Looking:
	gosub Send Q "look %Look.target" "$moveSuccessStrings|^In the .+ you see|^There is nothing in there\.$" "^That is closed\.$"
	if ("%Send.response" == "That is closed." && !Look.attemptedToOpen) then {
		gosub Open %Look.target
		var Look.attemptedToOpen 1
		goto Looking
	}
	if ("%Look.contents" == "null") then {
		var Look.contentsFullyListed -1
	}
	if ("%Look.contents" != "null") then {
		gosub Arrayify %Look.contents
		var Look.contentsList %Arrayify.string
		eval Look.contentsCount count("%Look.contentsList", "|")
		math Look.contentsCount add 1
	}
	if ("%Look.exits" != "null") then {
		gosub Arrayify %Look.exits
		var Look.exitList %Arrayify.string
	}
	action remove ^In the (.+) you see (.+)\.$
	action remove ^There is nothing in there\.$
	action remove ^(Obvious exits|Obvious paths|Ship paths): (.+)\.$
	return