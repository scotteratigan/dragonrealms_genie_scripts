#REQUIRE Send.cmd

gosub Pay %0
exit

Pay:
	var Pay.amount $0
	var Pay.success 0
Paying:
	# Note: no specific message for attempting to over-pay. It simply pays the correct amount and messages success.
	# However, game still checks that you have the total amount you're attempting to pay, even if > amount owed.
	# You can be lazy and pay a large amount, but you need that coinage on you for this to work.
	gosub Send Q "pay %Pay.amount" "^The clerk nods and takes your money, noting that your debt is now settled\.$|^The clerk nods, takes your money, and reminds you that you still owe \d+ (kronars|lirums|dokoras).$" "^But you don't have any (kronars|lirums|dokoras)\!$|^But you don't have \d+ (kronars|lirums|dokoras)\!$" "^The clerk looks up from some records and smiles wearily at you\.  She says, .It would appear you have no debts at this time, sir\.  How fortunate\!.$"
	var Pay.response %Send.response
	if ("%Send.success" == "1") then {
		var Pay.success 1
		return
	}
	return