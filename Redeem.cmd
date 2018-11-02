#REQUIRE Send.cmd

gosub Redeem %0
exit

Redeem:
	var Redeem.option $0
	var Redeem.success 0
Redeeming:
	gosub Send Q "redeem %Redeem.option" "^You quickly pocket .* tickets?\.$" "^The REDEEM verb is used to activate certain items\.  It has no default behavior or additional syntax\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Redeem.success 1
	return