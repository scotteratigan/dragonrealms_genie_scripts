#REQUIRE SendAttack.cmd

gosub Jab %0
exit

Jab:
	var Jab.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Jabbing:
	gosub SendAttack jab "%Jab.option"
	return