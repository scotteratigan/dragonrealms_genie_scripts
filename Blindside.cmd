#REQUIRE SendAttack.cmd

gosub Blindside %0
exit

Blindside:
	var Blindside.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 1
Blindsiding:
	gosub SendAttack blindside "%Blindside.option"
	return