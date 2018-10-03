#REQUIRE SendAttack.cmd

gosub Thrust %0
exit

Thrust:
	var Thrust.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Thrusting:
	gosub SendAttack thrust "%Thrust.option"
	return