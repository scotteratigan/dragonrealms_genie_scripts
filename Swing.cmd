#REQUIRE SendAttack.cmd

gosub Swing %0
exit

Swing:
	var Swing.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Swinging:
	gosub SendAttack swing "%Swing.option"
	return