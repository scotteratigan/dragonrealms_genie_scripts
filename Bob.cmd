#REQUIRE SendAttack.cmd

gosub Bob %0
exit

Bob:
	var Bob.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Bobbing:
	gosub SendAttack bob "%Bob.option"
	return