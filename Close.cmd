#REQUIRE Error.cmd
#REQUIRE Send.cmd

gosub Close %0
exit

Close:
	var Close.container $0
	var Close.success 0
	if "%Close.container" == "" then {
		gosub Error Close.cmd run with no container specified!
		return
	}
Closing:
	gosub Send Q "close %Close.container" "^You close.*$|^With a practiced flick of your wrist, you snap .+ closed\.$|^You carefully collapse the sections of the fishing pole, getting it ready for storage\.$" "^You can't close that\!$" "^That is already closed\.$|^It is already closed\.$|^But it's already been collapsed\!$"
	if (%Send.success == 1) then var Close.success 1
	return