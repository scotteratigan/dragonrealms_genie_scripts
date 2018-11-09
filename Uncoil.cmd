#REQUIRE Error.cmd
#REQUIRE Send.cmd
# todo: code uncoil.cmd

gosub Uncoil %0
exit

Uncoil:
	eval Uncoil.item $0
	if ("%Uncoil.item" == "") then {
		gosub Error Uncoil.cmd called without specifying an item.
		return
	}
Uncoiling:
	gosub Send Q "uncoil %Uncoil.item" "^You uncoil.+\.$" "FAILURE MESSAGES" "WARNING MESSAGES"
	return