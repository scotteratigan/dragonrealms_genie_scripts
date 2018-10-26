#REQUIRE Error.cmd
#REQUIRE Send.cmd

gosub Close %0
exit

Close:
	var Close.container $0
	if "%Close.container" == "" then {
		gosub Error Close.cmd run with no container specified!
		return
	}
Closing:
	gosub Send Q "close %Close.container" "^You close|^That is already closed\.$|^It is already closed\.$" "^You can't close that\!$"
	return