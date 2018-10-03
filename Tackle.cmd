#REQUIRE SendAttack.cmd

gosub Tackle %0
exit

Tackle:
	var Tackle.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Tackleing:
	gosub SendAttack Tackle "%Tackle.option"
	return