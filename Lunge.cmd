#REQUIRE SendAttack.cmd

gosub Lunge %0
exit

Lunge:
	var Lunge.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Lunging:
	gosub SendAttack lunge "%Lunge.option"
	return