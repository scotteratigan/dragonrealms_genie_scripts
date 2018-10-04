#REQUIRE SendAttack.cmd

gosub Fire %0
exit

Fire:
	var Fire.option $0
	var SendAttack.verb fire
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Firing:
	gosub SendAttack fire "%Fire.option"
	return