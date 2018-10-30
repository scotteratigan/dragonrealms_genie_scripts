#REQUIRE SendAttack.cmd

gosub Throw %0
exit

Throw:
	var Throw.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Throwing:
	gosub SendAttack throw "%Throw.option"
	return