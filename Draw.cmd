#REQUIRE SendAttack.cmd

gosub Draw %0
exit

Draw:
	var Draw.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Drawing:
	gosub SendAttack draw "%Draw.option"
	return