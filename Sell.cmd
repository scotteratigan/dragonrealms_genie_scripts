#REQUIRE Send.cmd

gosub Sell %0
exit

Sell:
	var Sell.item $0
	var Sell.success 0
	var Sell.amount 0
	var Sell.currency null
	action var Sell.amount $1;var Sell.currency $2 when ^\w+ takes your .+ and gives it a quick but thorough examination\.  After pausing for a moment, s?he hands you (\d+) (\w+) for it\.$
	action var Sell.amount $1;var Sell.currency $2 when ^The tanner \w+ ponders over the bundle for a while, then hands you (\d+) (\w+)\.$
Selling:
	gosub Send Q "sell %Sell.item" "^\w+ takes your .+ and gives it a quick but thorough examination\.  After pausing for a moment, s?he hands you .+ for it\.$|^The tanner \w+ ponders over the bundle for a while, then hands you .*$" "^\w+ looks puzzled, .Hmmm, I'm not sure what yer referring to\..$|^\w+ shakes \w+ head and says, .+ isn't worth my time\..$|^\w+ looks around and tries to find your .+\.  Finally s?he glares at you and says, .Trying to trick me, eh\?.$|^You can't pawn that\.$|^\w+ whistles and says, .There's folk around here that'd slit a throat for this\.  I may just wait and see what they want for it\.  Just in case you have, ummm, any problems holding on to it\..  \w+ chuckles coldly and adds, .I'd not sit with my back to any doors while carrying that around here\.." "WARNING MESSAGES"
	action remove ^\w+ takes your .+ and gives it a quick but thorough examination\.  After pausing for a moment, s?he hands you (\d+) (\w+) for it\.$
	action remove ^The tanner \w+ ponders over the bundle for a while, then hands you (\d+) (\w+)\.$
	var Sell.response %Send.response
	if ("%Send.success" == "1") then {
		var Sell.success 1
		echo Sold for %Sell.amount %Sell.currency
		return
	}
	return