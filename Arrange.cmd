#REQUIRE Send.cmd
# todo: test this

gosub Arrange %0
exit

Arrange:
	eval Arrange.option tolower("$0")
	if (matchre("%Arrange.option" "^all")) then {
		gosub ArrangeAll
		return
	}
Arranging:
	gosub Send W "arrange %Arrange.option" "^You begin to arrange|^You continue arranging|^You complete arranging" "^That has already been arranged as much as you can manage\.|^The .+'s already been skinned, there's no point\.$|^You don't know how to do that\.$|^The .+ cannot be skinned, so you can't arrange it either\.$"
	return

ArrangeAll:
	eval Arrange.option tolower("$0")
	gosub Arrange all %Arrange.option
	if ("%Send.message" == "You don't know how to do that.") {
		gosub Arrange %Arrange.option
		gosub Arrange %Arrange.option
		gosub Arrange %Arrange.option
		gosub Arrange %Arrange.option
		gosub Arrange %Arrange.option
	}
	return

