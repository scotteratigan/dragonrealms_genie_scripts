#REQUIRE Send.cmd

# Usage:
# wealth [kronars|lirums|dokoras]
# (currency is optional, omitting will display all 3 currencies)

gosub Wealth %0
exit

Wealth:
	var Wealth.option $0
	var Wealth.success 0
Wealthing:
	gosub Send RT "wealth %Wealth.option" "SUCCESS MESSAGES" "FAIL MESSAGES" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Wealth.success 1
	return