#REQUIRE SendAttack.cmd

gosub Punch %0
exit

Punch:
	var Punch.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Punching:
	gosub SendAttack punch "%Punch.option"
	return