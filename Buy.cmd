#REQUIRE Refuse.cmd
#REQUIRE Send.cmd

# See also: Offer.cmd and Refuse.cmd if adding new merchant.

# Note: there are two different types of BUYing:
# 1 - barter method: buy item, offer x, offer x (strings are often unique to merchants)
# 2 - shop method: buy item and you've got it (generic matches)

gosub Buy %0
exit

Buy:
	var Buy.command $0
	var Buy.success 0
	var Buy.purchased 0
	var Buy.successMessages ^Berolt smiles and says, .A good choice.*$
	var Buy.failureMessages ^Berolt glances at you with a puzzled expression\..*$
	var Buy.alreadyHagglingMessages ^Berolt furrows his brow and says, .Oh dear, I'm afraid I can't handle more than one haggle at a time.*$
	action var Buy.needToRefuse 1 when %Buy.alreadyHagglingMessages
	action var Buy.purchased 1 when ^You decide to purchase .+, and pay .+\.$
Buying:
	var Buy.needToRefuse 0
	gosub Send Q "buy %Buy.command" "^You decide to purchase .+, and pay .+\.$|%Buy.successMessages" "^You realize you don't have that much\.$|^Buy what\?|^That .+ is not for sale\.$|%Buy.failureMessages|%Buy.alreadyHagglingMessages" "WARNING MESSAGES"
	action remove %Buy.alreadyHagglingMessages
	action remove ^You decide to purchase .+, and pay .+\.$
	var Buy.response %Send.response
	if ("%Send.success" == "1") then {
		var Buy.success 1
		return
	}
	# Note: couldn't just do matchre on the Buy.response because it contains quotes.
	if (%Buy.needToRefuse == 1) then {
		gosub Refuse
		if (%Refuse.success == 1) then goto Buying
	}
	return

# Currently implemented:
# [Berolt's Dry Goods, Showroom]