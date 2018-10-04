#REQUIRE Send.cmd
#REQUIRE Error.cmd

gosub Arrange %0
exit

ArrangeAll:
	gosub Arrange all $0
	return

Arrange:
	eval Arrange.option tolower("$0")
Arranging:
	# note Arrange.option and arrange.options are different. I'm not in love with this solution, but it is very flexible.
	var Arrange.option $0
	gosub ArrangeActual
	if ("%Send.response" == "You don't know how to do that.") then {
		# Character doesn't know the technique for arranging, try to arrange 5x instead.
		eval Arrange.option replacere("%Arrange.option", "^all ?", "")
		echo Arrange.option is %Arrange.option
		gosub ArrangeUntilComplete
	}
	return

ArrangeActual:
	gosub Send W "arrange %Arrange.option" "^You begin to arrange|^You continue arranging|^You complete arranging|^That has already been arranged as much as you can manage\." "^Arrange what\?|^The .+'s already been skinned, there's no point\.$|^You don't know how to do that\.$|^The .+ cannot be skinned, so you can't arrange it either\.$|^Try killing the .+ before you arrange it\.$"
	if (%Send.success == 0) then {
		gosub Error %Send.response
	}
	return

ArrangeUntilComplete:
	gosub ArrangeActual
	if (%Send.success == 0) then return
	if (matchre("%Send.response", "^You complete arranging|^That has already been arranged")) then return
	goto ArrangeUntilComplete

