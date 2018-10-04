#REQUIRE SendAttack.cmd

gosub Pummel %0
exit

Pummel:
	var Pummel.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Pummeling:
	gosub SendAttack pummel "%Pummel.option"
	return