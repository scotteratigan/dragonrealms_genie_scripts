#REQUIRE SendAttack.cmd

gosub Bite %0
exit

Bite:
	var Bite.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 1
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Biting:
	gosub SendAttack bite "%Bite.option"
	return