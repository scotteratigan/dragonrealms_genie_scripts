#REQUIRE SendAttack.cmd

gosub Sweep %0
exit

Sweep:
	var Sweep.option $0
	var SendAttack.requiresWeapon 1
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Sweeping:
	gosub SendAttack sweep "%Sweep.option"
	return