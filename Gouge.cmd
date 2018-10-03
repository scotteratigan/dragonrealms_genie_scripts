#REQUIRE SendAttack.cmd

gosub Gouge %0
exit

Gouge:
	var Gouge.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Gouging:
	gosub SendAttack gouge "%Gouge.option"
	return