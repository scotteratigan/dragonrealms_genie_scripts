#REQUIRE Send.cmd

# See also: Buy.cmd and Offer.cmd if adding new merchant.

gosub Refuse %0
exit

Refuse:
	var Refuse.success 0
	var Refuse.successMessages ^Berolt shrugs his shoulders and walks away, hoping you will return to do business soon\.$
	var Refuse.nothingToRefuseMessages ^Berolt peers quizically at you\.  .I'm sorry, were you interested in buying something.*$
	gosub Send Q "refuse" "%Refuse.successMessages" "^You must be in the room with a merchant to REFUSE an offer\.$" "%Refuse.nothingToRefuseMessages"
	var Refuse.response %Send.response
	if ("%Send.success" == "1") then {
		var Refuse.success 1
		return
	}
	return