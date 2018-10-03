#REQUIRE SendAttack.cmd

gosub Claw %0
exit

Claw:
	var Claw.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Clawing:
	gosub SendAttack claw "%Claw.option"
	return