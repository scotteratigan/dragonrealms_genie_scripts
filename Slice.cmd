#REQUIRE SendAttack.cmd

gosub Slice %0
exit

Slice:
	var Slice.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Sliceing:
	gosub SendAttack slice "%Slice.option"
	return