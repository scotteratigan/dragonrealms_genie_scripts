#REQUIRE Send.cmd

gosub Encumbrance
exit

Encumbrance:
	var Encumbrance.success 0
	var Encumbrance.text null
	var Encumbrance.level -1
	action var Encumbrance.text $1 when ^  Encumbrance : (.+)$
	gosub Send Q "encumbrance" "^\s*Encumbrance : .+$" "FAIL MESSAGES" "WARNING MESSAGES"
	action remove ^  Encumbrance : (.+)$
	if (%Send.success == 1) then {
		var Encumbrance.success 1
		if ("%Encumbrance.text" == "None") then {
			var Encumbrance.level 0
			return
		}
		if ("%Encumbrance.text" == "Light Burden") then {
			var Encumbrance.level 1
			return
		}
		if ("%Encumbrance.text" == "Somewhat Burdened") then {
			var Encumbrance.level 2
			return
		}
		if ("%Encumbrance.text" == "Burdened") then {
			var Encumbrance.level 3
			return
		}
		if ("%Encumbrance.text" == "Heavy Burden") then {
			var Encumbrance.level 4
			return
		}
		if ("%Encumbrance.text" == "Very Heavy Burden") then {
			var Encumbrance.level 5
			return
		}
		if ("%Encumbrance.text" == "Overburdened") then {
			var Encumbrance.level 6
			return
		}
		if ("%Encumbrance.text" == "Very Overburdened") then {
			var Encumbrance.level 7
			return
		}
		if ("%Encumbrance.text" == "Extremely Overburdened") then {
			var Encumbrance.level 8
			return
		}
		if ("%Encumbrance.text" == "Tottering Under Burden") then {
			var Encumbrance.level 9
			return
		}
		if ("%Encumbrance.text" == "Are you even able to move?") then {
			var Encumbrance.level 10
			return
		}
		if ("%Encumbrance.text" == "It's amazing you aren't squashed!") then {
			var Encumbrance.level 11
			return
		}
	}
	return