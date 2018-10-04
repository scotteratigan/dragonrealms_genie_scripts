#REQUIRE SendAttack.cmd

gosub Knee %0
exit

Knee:
	var Knee.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 1
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Kneeing:
	gosub SendAttack knee "%Knee.option"
	return