#REQUIRE SendAttack.cmd

gosub Hurl %0
exit

Hurl:
	var Hurl.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Hurling:
	gosub SendAttack hurl "%Hurl.option"
	return