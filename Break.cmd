#REQUIRE Send.cmd
#REQUIRE Stand.cmd

gosub Break %0
exit

Break:
	var Break.command $0
	var Break.success 0
Breaking:
	gosub Send Q "break %Break.command" "^Grasping the .+ pumpkin firmly,.*$|^You break off the earth coating.  Beneath it is revealed .+\.$|^You struggle with a dried serpent husk until .*$" "^Break what\?$|^You can't break that\.$|^You'll need a free hand to do that\!$|^Perhaps that would work better if you were standing\.$|^A nearby attendant says, .Oh no you don't\!  If you want to smash one of the pumpkins, take it out to the entrance hall\.  We're trying to keep this room clean\!." "WARNING MESSAGES"
	var Break.response %Send.response
	if ("%Send.success" == "1") then {
		var Break.success 1
		return
	}
	if ("%Break.response" == "Perhaps that would work better if you were standing.") then {
		gosub Stand
		if (%Stand.success) then goto Breaking
	}
	return

# Note: this means you need to check health & tend:
# Grasping the orange pumpkin firmly, you bring it up swiftly into your forehead.  With a grimace, you wipe off pumpkin residue on the back of your forearm.  Fragments from the orange pumpkin fly upwards through the air, only to rain down around you afterwards.