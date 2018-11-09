#REQUIRE Send.cmd

gosub Tend %0
exit

Tend:
	var Tend.target $0
	var Tend.success 0
Tending:
	gosub Send RT "tend %Tend.target" "^You deftly remove.*$|^You work carefully at tending your wound\.$" "^Your .+ (is|are) too injured for you to do that\.$" "^That area is not bleeding\.$|^That area has already been tended to\.$|^You may tend bleeding wounds on yourself or others\.  For more information, please type: TEND HELP\.$"
	var Tend.response %Send.response
	if ("%Send.success" == "1") then var Tend.success 1
	return