#REQUIRE Block.cmd
#REQUIRE Send.cmd

gosub FACE %0
exit

FACE:
	# Faces an opponent to allow engagement
		var FACE.option $0
	FACING:
		if ("%FACE.option" == "") then var FACE.option next
		gosub Send Q "face %FACE.option" "^You turn to face|^You are already facing .+\.$" "^There is nothing else to face\!$|^FACE HELP for more information$|^You are too closely engaged and will have to retreat first\.$"
		if ("SEND.message" == "You are too closely engaged and will have to retreat first.") then {
			gosub BLOCK stop
			goto FACING
		}
		return