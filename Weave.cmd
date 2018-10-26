#REQUIRE SendAttack.cmd

gosub Weave %0
exit

Weave:
	var Weave.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Weaving:
	gosub SendAttack weave "%Weave.option"
	return