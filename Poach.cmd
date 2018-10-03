#REQUIRE SendAttack.cmd

gosub Poach %0
exit

Poach:
	var Poach.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 1
Poaching:
	gosub SendAttack poach "%Poach.option"
	return