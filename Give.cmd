#REQUIRE Send.cmd

gosub Give %0
exit

Give:
	var Give.command $0
	var Give.success 0
Giving:
	var Give.again 0
	action var Give.again 1 when ^A clerk looks over the .+ and says, .That will cost \d+ \w+ to repair\.  Just give it to me again if you want, and I'll have it ready in \d+ \w+\..$
	gosub Send Q "give %Give.command" "^You offer your .+ to \w+, who has 30 seconds to accept the offer\.  Type CANCEL to prematurely cancel the offer\.$|^You hand the clerk your ticket and are handed back .+\.$|^The workman's eyes light up when he sees you approach.*$|^The farmer takes your money and chuckles.*$|^Dealer Poltu takes your .+ and inspects the craftsmanship\.  He smirks and exclaims, .Well what do you know\.  The .+ came through after all\.  Well done\!  I'll take it\!.$|^You hand the clerk \d+ \w+ and s?he gives you back a repair ticket\.  .+ says, .I should be having that done for you in about \d+ \w+\.  Don't lose this ticket\!  You must have it to reclaim your .+\..$" "^What is it you're trying to give\?$" "^A clerk looks over the .+ and says, .That will cost \d+ \w+ to repair\.  Just give it to me again if you want, and I'll have it ready in \d+ \w+\..$|^The farmer says, .You haven't finished playing the last game\!  Get back in there and fire off the rest of your pumpkins\!.|^A clerk says, .There isn't a scratch on that, so there's nothing to repair\..$"
	var Give.response %Send.response
	action remove ^A clerk looks over the .+ and says, .That will cost \d+ \w+ to repair\.  Just give it to me again if you want, and I'll have it ready in \d+ \w+\..$
	if (%Give.again == 1) then goto Giving
	if ("%Send.success" == "1") then {
		var Give.success 1
		return
	}
	return
#A clerk says politely, "That won't be done for another 5 roisaen."
#A clerk says politely, "That won't be done for another roisaen or so."
#A clerk says politely, "That is almost done, just give me a few more moments here."