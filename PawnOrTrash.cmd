#REQUIRE Pawn.cmd
#REQUIRE Trash.cmd

gosub PawnOrTrash %0
exit

PawnOrTrash:
	var PawnOrTrash.item $0
	var PawnOrTrash.success 0
PawnOrTrashing:
	gosub Pawn %PawnOrTrash.item
	var PawnOrTrash.response %Pawn.response
	if ("%Pawn.success" == 1) then {
		var PawnOrTrash.success 1
		return
	}
	gosub Trash %PawnOrTrash.item
	var PawnOrTrash.response %Trash.response
	return