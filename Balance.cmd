#REQUIRE Send.cmd

gosub Balance %0
exit

Balance:
	var Balance.success 0
	# Todo: get more balance messages
	var Balance.copper 0
	var Balance.bronze 0
	var Balance.silver 0
	var Balance.gold 0
	var Balance.platinum 0
	var Balance.currency null
	action var Balance.copper $2;var Balance.currency $3 when ^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).* (\d+) copper.*(Kronars|Lirums|Dokoras)\.$
	action var Balance.bronze $2;var Balance.currency $3 when ^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).* (\d+) bronze.*(Kronars|Lirums|Dokoras)\.$
	action var Balance.silver $2;var Balance.currency $3 when ^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).* (\d+) silver.*(Kronars|Lirums|Dokoras)\.$
	action var Balance.gold $2;var Balance.currency $3 when ^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).* (\d+) gold.*(Kronars|Lirums|Dokoras)\.$
	action var Balance.platinum $2;var Balance.currency $3 when ^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).* (\d+) platinum.*(Kronars|Lirums|Dokoras)\.$
	gosub Send Q "balance" "^(The clerk pages through|You find your jar with little effort|Searching methodically through the shelves).*$|^You are solidly balanced\.$" "FAIL MESSAGES" "WARNING MESSAGES"
	var Balance.response %Send.response
	action remove ^The clerk pages through.* (\d+) copper (Kronars|Lirums|Dokoras)\..$
	action remove ^The clerk pages through.* (\d+) bronze.*(Kronars|Lirums|Dokoras)\..$
	action remove ^The clerk pages through.* (\d+) silver.*(Kronars|Lirums|Dokoras)\..$
	action remove ^The clerk pages through.* (\d+) gold.*(Kronars|Lirums|Dokoras)\..$
	action remove ^The clerk pages through.* (\d+) platinum.*(Kronars|Lirums|Dokoras)\..$
	if ("%Send.success" == "1") then var Balance.success 1
	if ("%Balance.currency" != "null") then {
		evalmath Balance.totalCopper %Balance.copper + (10 * %Balance.bronze) + (100 * %Balance.silver) + (1000 * %Balance.gold) + (10000 * %Balance.platinum)
		echo Total copper: %Balance.totalCopper
	}
	return

#The clerk pages through her ledger.  "Rellie, it looks like your current balance is 18610 platinum, 5 gold, 1 silver, 8 bronze, and 1 copper Dokoras."