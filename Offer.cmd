#REQUIRE Refuse.cmd
#REQUIRE Send.cmd

# See also: Buy.cmd and Refuse.cmd if adding new merchant.

gosub Offer %0
exit

Offer:
	var Offer.command $0
	# Note: offer.success means that the merchant is considering your offer or has accepted it. It does not necessarily indicate that the item was purchased successfully.
	var Offer.success 0
	# Offer.purchase indicates if we bought the item or not.
	var Offer.notBuyingMessages ^.My, that is generous\!. Berolt gushes, .But shouldn't you order something first.*$
	var Offer.tooLowMessages ^.Tell you what,. Berolt winks, .you come back when you're ready to do some real business, okay.*$
	var Offer.tooHighMessages ^An offer of \d+\?  Are you SURE\?  \(OFFER it again within the next 20 seconds if you are\.\)$
	var Offer.barterMessages ^Berolt strokes his chin and says, .Well, if it's a bargain you're after, how about (\d+)\?.*$
	var Offer.barterRejectedMessages ^Berolt shifts his weight as he considers your offer\.  .I'm sorry, \w+, that is lower than I can go.*$
	var Offer.purchasedMessages ^Berolt grins as he hands you your purchase\.$
	action var Offer.merchantNewPrice $1 when %Offer.merchantNewPrice
	action var Offer.purchased 1 when %Offer.purchasedMessages
Offering:
	var Offer.merchantNewPrice 0
	var Offer.purchased 0
	gosub Send Q "offer %Offer.command" "%Offer.barterMessages|%Offer.purchasedMessages" "^You realize to your horror that you don't have enough money\.$|^You must be in the room with a merchant to OFFER money to him or her\.  If you are trying to hand an object to someone, try using GIVE\.$|%Offer.notBuyingMessages|%Offer.tooLowMessages" "%Offer.tooHighMessages"
	action remove %Offer.merchantNewPrice
	action remove %Offer.purchasedMessages
	var Offer.response %Send.response
	if ("%Send.success" == "1") then {
		var Offer.success 1
		return
	}
	return

# Currently implemented:
# [Berolt's Dry Goods, Showroom]