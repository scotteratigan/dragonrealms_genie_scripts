#REQUIRE SendAttack.cmd

gosub Elbow %0
exit

Elbow:
	var Elbow.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Elbowing:
	gosub SendAttack elbow "%Elbow.option"
	return