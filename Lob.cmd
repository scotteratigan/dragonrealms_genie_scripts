#REQUIRE SendAttack.cmd

gosub Lob %0
exit

Lob:
	var Lob.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Lobing:
	gosub SendAttack lob "%Lob.option"
	return