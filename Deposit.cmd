#REQUIRE Send.cmd

gosub Deposit %0
exit

Deposit:
	var Deposit.amount $0
	# Default to depositing all if not specified:
	if ("%Deposit.amount" == "") then var Deposit.amount all
	var Deposit.success 0
Depositing:
	gosub Send Q "deposit %Deposit.amount" "^The clerk slides a small metal box across the counter.*$|^Searching methodically through the shelves, you finally manage to locate the jar labeled \S+, and drop your coins.*$|^You find your jar with little effort, thankfully, and drop your coins.*$" "^There is no teller here\.$|^You don't have that many .*$|^You don't have any.*$|^The clerk glares at you\.  .I don't know what you think you're doing \w+, but I don't like it much\..$" "WARNING MESSAGES"
	var Deposit.response %Send.response
	if ("%Send.success" == "1") then {
		var Deposit.success 1
		return
	}
	return