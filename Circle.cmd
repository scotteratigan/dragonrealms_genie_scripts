#REQUIRE SendAttack.cmd

gosub Circle %0
exit

Circle:
	var Circle.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Circling:
	gosub SendAttack circle "%Circle.option"
	return