#REQUIRE SendAttack.cmd

gosub Slam %0
exit

Slam:
	var Slam.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Slamming:
	gosub SendAttack slam "%Slam.option"
	return