#REQUIRE SendAttack.cmd

gosub Slap %0
exit

Slap:
	var Slap.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Slapping:
	gosub SendAttack slap "%Slap.option"
	return