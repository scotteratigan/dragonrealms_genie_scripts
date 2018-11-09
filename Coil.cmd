#REQUIRE Error.cmd
#REQUIRE Send.cmd
# todo: code uncoil.cmd

gosub Coil %0
exit

Coil:
	eval Coil.item $0
	if ("%Coil.item" == "") then {
		gosub Error Coil.cmd called without specifying an item.
		return
	}
Coiling:
	gosub Send Q "coil %Coil.item" "^You coil up your .+\.$" "^Coil what\?$|^You can't coil that\.$" ""
	return