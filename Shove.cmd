#REQUIRE SendAttack.cmd

gosub Shove %0
exit

Shove:
	var Shove.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Shoveing:
	gosub SendAttack shove "%Shove.option"
	return