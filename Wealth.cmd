#REQUIRE Send.cmd

# Usage:
# wealth [kronars|lirums|dokoras]
# (currency is optional, omitting will display all 3 currencies)

# Sets the following variables:
# Wealth.debtZoluren, .debtTherengia, .debtIlithi, .debtQi, .debtForfedhdar (total debt per province, in copper)
# Wealth.kronars, .lirums, .dokoras (total coin on hand by currency, in copper)
# Wealth.kronars.platinum, .kronars.gold, etc per currency and denomination, for a total of 15 variables.
# Note: Wealth.currency is a temporary variable with no real meaning outside of runtime.

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
	# These detailed triggers are unique to this script:
	action var Wealth.kronars.platinum 0;var Wealth.kronars.gold 0;var Wealth.kronars.silver 0;var Wealth.kronars.bronze 0;var Wealth.kronars.copper 0;var Wealth.lirums.platinum 0;var Wealth.lirums.gold 0;var Wealth.lirums.silver 0;var Wealth.lirums.bronze 0;var Wealth.lirums.copper 0;var Wealth.dokoras.platinum 0;var Wealth.dokoras.gold 0;var Wealth.dokoras.silver 0;var Wealth.dokoras.bronze 0;var Wealth.dokoras.copper 0; when ^Wealth:
	action eval Wealth.currency tolower($2);var Wealth.%Wealth.currency.platinum $1 when ^  (\d+) platinum.*(Kronars|Lirums|Dokoras)\)\.$
	action eval Wealth.currency tolower($2);var Wealth.%Wealth.currency.gold $1 when (\d+) gold.*(Kronars|Lirums|Dokoras)\)\.$
	action eval Wealth.currency tolower($2);var Wealth.%Wealth.currency.silver $1 when (\d+) silver.*(Kronars|Lirums|Dokoras)\)\.$
	action eval Wealth.currency tolower($2);var Wealth.%Wealth.currency.bronze $1 when (\d+) bronze.*(Kronars|Lirums|Dokoras)\)\.$
	action eval Wealth.currency tolower($2);var Wealth.%Wealth.currency.copper $1 when (\d+) copper.*(Kronars|Lirums|Dokoras)\)\.$
	gosub Send Q "wealth %Wealth.option" "^Wealth:" "^What kind of a coin is .*\?$" "WARNING MESSAGES"
	pause .1
	if ("%Send.success" == "1") then var Wealth.success 1
	action remove when ^\s+No (Kronars|Lirums|Dokoras)\.$
	action remove when ^\s+\d+.*\((\d+) copper (Kronar|Lirum|Dokora)s?\)\.$
	action remove ^Debt:
	action remove ^  You owe .+ (\S+)\. \((\d+) copper (Kronars|Lirums|Dokoras)\)$
	return

#Example:
#Debt:
#  You owe 4 gold and 5 bronze Dokoras to the Domain of Ilithi. (4050 copper Dokoras)
#
#Wealth:
#  No Kronars.
#  7 copper Lirums (7 copper Lirums).
#  1 platinum, 2 gold, 3 silver, 4 bronze, and 6 copper Dokoras (12346 copper Dokoras).