#REQUIRE SendAttack.cmd

gosub Bash %0
exit

Bash:
	var Bash.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Bashing:
	gosub SendAttack bash "%Bash.option"
	return