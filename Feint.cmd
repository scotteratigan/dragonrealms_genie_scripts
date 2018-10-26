#REQUIRE SendAttack.cmd

gosub Feint %0
exit

Feint:
	var Feint.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Feinting:
	gosub SendAttack feint "%Feint.option"
	return