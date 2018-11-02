#REQUIRE Sell.cmd

gosub Pawn %0
exit

Pawn:
	var Pawn.item $0
	var Pawn.success 0
Pawning:
	gosub Sell %Pawn.item
	var Pawn.response %Sell.response
	if ("%Sell.success" == 1) then {
		var Pawn.success 1
		return
	}
	return