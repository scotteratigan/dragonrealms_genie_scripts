#REQUIRE Block.cmd
#REQUIRE Send.cmd

gosub Face %0
exit

Face:
	# Faces an opponent to allow engagement
		var Face.option $0
	Facing:
		if ("%Face.option" == "") then var Face.option next
		gosub Send Q "face %Face.option" "^You turn to face|^You are already facing .+\.$" "^There is nothing else to face\!$|^Face HELP for more information$|^You are too closely engaged and will have to retreat first\.$"
		if ("Send.message" == "You are too closely engaged and will have to retreat first.") then {
			gosub Block stop
			goto Facing
		}
		return