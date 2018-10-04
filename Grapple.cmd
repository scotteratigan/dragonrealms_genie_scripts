#REQUIRE SendAttack.cmd

gosub Grapple %0
exit

Grapple:
	var Grapple.option $0
	var SendAttack.requiresWeapon 0
	var SendAttack.requiresGrapple 0
	var SendAttack.isDamaging 0
	var SendAttack.requiresStealth 0
Grappling:
	gosub SendAttack grapple "%Grapple.option"
	return

#You grab hold of a wood troll in a tight grip.  A wood troll grips you back.

#[grapple]: grapple
#You reach out toward a wood troll but are unable to make contact.
#[You're solidly balanced with no advantage.]
#Roundtime: 4 sec.