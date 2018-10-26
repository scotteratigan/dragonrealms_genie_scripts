#REQUIRE SendAttack.cmd

gosub Snipe %0
exit

Snipe:
	var Snipe.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 1
Sniping:
	gosub SendAttack snipe "%Snipe.option"
	return