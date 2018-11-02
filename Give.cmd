#REQUIRE Send.cmd

gosub Give %0
exit

Give:
	var Give.command $0
	var Give.success 0
Giveing:
	gosub Send Q "give %Give.command" "^You offer your .+ to \w+, who has 30 seconds to accept the offer\.  Type CANCEL to prematurely cancel the offer\.$|^The workman's eyes light up when he sees you approach.*$|^The farmer takes your money and chuckles.*$" "^What is it you're trying to give\?$" "^The farmer says, .You haven't finished playing the last game\!  Get back in there and fire off the rest of your pumpkins\!."
	var Give.response %Send.response
	if ("%Send.success" == "1") then {
		var Give.success 1
		return
	}
	return