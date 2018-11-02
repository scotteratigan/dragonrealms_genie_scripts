#REQUIRE SendAttack.cmd

# Note: this is for the headbutt attack, which was given the humorous command name of 'butt'.

gosub Butt %0
exit

Butt:
	var Butt.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 1
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Butting:
	gosub SendAttack butt "%Butt.option"
	return