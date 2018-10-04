#REQUIRE Advance.cmd
#REQUIRE Send.cmd
gosub Attack %0
exit

Attack:
	# todo: add guild-only attacks barbarian, paladin?
	# Default/regular attack:
	var Attack.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 1
	var SendAttack.requiresStealth 0
Attacking:
	gosub SendAttack attack "%Attack.option"
	return