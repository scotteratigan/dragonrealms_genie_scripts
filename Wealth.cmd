#REQUIRE Send.cmd

# Usage:
# wealth [kronars|lirums|dokoras]
# (currency is optional, omitting will display all 3 currencies)

gosub Wealth %0
exit

Wealth:
	var Wealth.option $0
	var Wealth.success 0
	# Note: triggers here are identical to Info.cmd, only difference is the variable names:
	action eval Wealth.currency tolower($1);var Wealth.%Wealth.currency 0 when ^\s+No (Kronars|Lirums|Dokoras)\.$
	action eval Wealth.currency tolower($2s);var Wealth.%Wealth.currency $1 when ^\s+\d+.*\((\d+) copper (Kronar|Lirum|Dokora)s?\)\.$
	action var Wealth.debtZoluren 0;var Wealth.debtTherengia 0;var Wealth.debtIlithi 0;var Wealth.debtQi 0;var Wealth.debtForfedhdar 0 when ^Debt:
	action var Wealth.debtProvince $1;var Wealth.debt%Wealth.debtProvince $2 when ^  You owe .+ (\S+)\. \((\d+) copper (Kronars|Lirums|Dokoras)\)$
	# Todo: add triggers to capture the actual number of each coin type per currency.
	gosub Send RT "wealth %Wealth.option" "^Wealth:" "^What kind of a coin is .*\?$" "WARNING MESSAGES"
	pause .1
	if ("%Send.success" == "1") then var Wealth.success 1
	action remove when ^\s+No (Kronars|Lirums|Dokoras)\.$
	action remove when ^\s+\d+.*\((\d+) copper (Kronar|Lirum|Dokora)s?\)\.$
	action remove ^Debt:
	action remove ^  You owe .+ (\S+)\. \((\d+) copper (Kronars|Lirums|Dokoras)\)$
	return