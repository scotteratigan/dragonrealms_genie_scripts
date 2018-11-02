#REQUIRE Error.cmd
#REQUIRE Send.cmd

gosub Exchange %0
exit

Exchange:
	var Exchange.command $0
	var Exchange.success 0
	# Exchange.fee is (a trivial, a modest, an exorbitant, etc)
	var Exchange.fee null
	if ("%Exchange.command" == "") then {
		gosub Error Exchange called with no details specified.
		return
	}
	#You hand your 1 platinum Kronars to the money-changer.  After collecting a modest fee, he hands you 7 gold, and 6 silver Lirums.
	action var Exchange.fee $1 when ^You hand your .+ to the money-changer\.  After collecting (.+) fee, s?he hands you .*\.$
	action var Exchange.fee $1 when ^You count out .+ and drop them in the proper jar\.  After figuring (.+) fee.*$
	action var Exchange.fee none when ^You hand your .+ to the money-changer\.  \w+ whispers, .Enjoy the holiday, friend\!  There's no fee this time\!.  \w+ hands you .*\.$|^You count out .+ and drop them in the proper jar\.  After figuring a nonexistent fee in the ledger beside the jar, you reach into the one filled with \w+ and withdraw .+\.$
Exchanging:
	gosub Send Q "exchange %Exchange.command" "^You hand your .+ to the money-changer\.  After collecting .+ fee, s?he hands you .*\.$|^You count out .+ and drop them in the proper jar\.  After figuring .+ fee.*$|^You hand your .+ to the money-changer\.  \w+ whispers, .Enjoy the holiday, friend\!  There's no fee this time\!.  \w+ hands you .*\.$|^You count out .+ and drop them in the proper jar\.  After figuring a nonexistent fee in the ledger beside the jar, you reach into the one filled with \w+ and withdraw .+\.$" "^There is no money-changer here\.$|^You don't have that many .+ to exchange\.$|^You start to count out your .+ but realize you don't have as many as you thought\.$|^But you don't have any \w+\.$|^The money-changer says crossly, .A transaction that small isn't worth my time\.  The minimum is one bronze or ten coppers\..$^The money-changer coughs and glances around\.  .I'd really rather not handle transactions larger than a thousand platinum\..$|^The money-changer says, .I'm not sure what you're getting at.*$" "WARNING MESSAGES"
	action remove ^You hand your .+ to the money-changer\.  After collecting (.+) fee, s?he hands you .*\.$
	action remove ^You count out .+ and drop them in the proper jar\.  After figuring (.+) fee.*$
	action remove ^You hand your .+ to the money-changer\.  \w+ whispers, .Enjoy the holiday, friend\!  There's no fee this time\!.  \w+ hands you .*\.$|^You count out .+ and drop them in the proper jar\.  After figuring a nonexistent fee in the ledger beside the jar, you reach into the one filled with \w+ and withdraw .+\.$
	var Exchange.response %Send.response
	echo fee is %Exchange.fee
	if ("%Send.success" == "1") then {
		var Exchange.success 1
		return
	}
	return