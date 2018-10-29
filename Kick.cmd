#REQUIRE SendAttack.cmd

gosub Kick %0
exit

Kick:
	var Kick.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Gouging:
	gosub SendAttack kick "%Kick.option"
	return