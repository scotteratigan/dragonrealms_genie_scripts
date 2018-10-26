#REQUIRE SendAttack.cmd

gosub Chop %0
exit

Chop:
	var Chop.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Chopping:
	gosub SendAttack chop "%Chop.option"
	return