#REQUIRE Send.cmd

gosub Combine %0
exit

Combine:
	var Combine.command $0
	var Combine.success 0
	if ("%Combine.command" == "") then {
		if (!contains("$righthand $lefthand", "Empty")) then var Combine.command #$righthandid with #$lefthandid
	}
Combining:
	gosub Send Q "Combine %Combine.command" "^You combine the bolts of cloth together\.$" "^You must be holding both substances to combine them\.  For more information, see HELP VERB COMBINE\.$|^You fumble around with the cloth and cloth, but are unable to combine them\.  Perhaps if they were the same thickness of material you could do better\.$|You fumble around with the cloths, but are unable to combine them\.  Perhaps if they were the same type of material you could do better\.$" "WARNING MESSAGES"
	var Combine.response %Send.response
	if ("%Send.success" == "1") then {
		var Combine.success 1
		return
	}
	return