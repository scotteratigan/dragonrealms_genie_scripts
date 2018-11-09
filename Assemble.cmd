#REQUIRE Send.cmd

gosub Assemble %0
exit

Assemble:
	var Assemble.command $0
	var Assemble.success 0
Assembleing:
	gosub Send Q "assemble %Assemble.command" "^You slide .+ onto .+ and affix it securely in place\.$|^You slide .+ over the tang of your hilt and tighten the pommel to secure it\.$" "^The .+ must be in your hands or on the ground to continue assembly\.$|^You must be holding either .+ or .+ to begin assembly\.$|^The .+ is not required to continue crafting .+, so you stop assembling them\.$" "WARNING MESSAGES"
	var Assemble.response %Send.response
	if ("%Send.success" == "1") then {
		var Assemble.success 1
		return
	}
	return