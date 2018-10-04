#REQUIRE Advance.cmd
#REQUIRE Send.cmd

gosub SendAttack %0
exit

SendAttack:
	var SendAttack.verb $1
	var SendAttack.option $2
SendingAttack:
	# todo: vitality check?
	# todo: ifnotdefined check before defining all these vars?
	var benignDamage 0
	var brushingDamage 0
	var gentleDamage 0
	var glancingDamage 0
	var grazingDamage 0
	var harmlessDamage 0
	var ineffectiveDamage 0
	var skimmingDamage 0
	var lightDamage 1
	var goodDamage 2
	var solidDamage 3
	var hardDamage 4
	var strongDamage 5
	var heavyDamage 6
	var veryDamage 7
	var extremelyDamage 8
	var powerfulDamage 9
	var massiveDamage 10
	var awesomeDamage 11
	var viciousDamage 12
	var earth-shakingDamage 13
	var demolishingDamage 14
	var spine-rattlingDamage 15
	var devastatingDamage 16
	var overwhelmingDamage 17
	var obliteratingDamage 18
	var annihilatingDamage 19
	var cataclysmicDamage 20
	var apocalypticDamage 21
	var SendAttack.succeeded 0
	var SendAttack.landed 0
	var SendAttack.damageMessage null
	var SendAttack.damageLevel -1
	action var SendAttack.succeeded 1 when ^< .*$
	action var SendAttack.landed 1 when ^The .* lands?
	action var SendAttack.damageMessage $1 $2 $3 when ^The .* lands? (a|an) (benign|brushing|gentle|glancing|grazing|harmless|ineffective|skimming|light|good|good|solid|hard|strong|heavy|very heavy|extremely heavy|powerful|massive|awesome|vicious|earth-shaking|demolishing|spine-rattling|devastating|overwhelming|obliterating|annihilating|cataclysmic|apocalyptic) (blow|hit|strike)
	action var SendAttack.damageLevel %$2Damage when ^The .* lands? (a|an) (benign|brushing|gentle|glancing|grazing|harmless|ineffective|skimming|light|good|good|solid|hard|strong|heavy|very|extremely|powerful|massive|awesome|vicious|earth-shaking|demolishing|spine-rattling|devastating|overwhelming|obliterating|annihilating|cataclysmic|apocalyptic)
	#< Moving with dominating grace, you gouge your fingers at a ship's rat.  A ship's rat attempts to dodge, moving directly into the blow.  
	#XML-<popBold/>-XML
	#The fingers lands an apocalyptic strike (So that's what it felt like when Grazhir shattered!) that penetrates deeply into the muscles of the chest, stunning it.
	#[You're nimbly balanced and in superior position.]
	#[Roundtime 1 sec.]
	if (%SendAttack.requiresWeapon == 1) then {
		if (("$righthand" == "Empty") || ("$lefthand" == "Empty" && contains("%Attack.option", "left")) then {
			# right hand is empty, or attack type is left but left hand is empty.
			gosub Error No weapon to %SendAttack.verb %SendAttack.option with!
			return
		}
	}
	gosub Send RT "%SendAttack.verb %SendAttack.option" "^\[Roundtime \d+ sec\.\]$|^Roundtime: \d+ sec\.$" "^You aren't close enough to attack\.$|^The .+ is already quite dead\.$|^What are you trying to attack\?|^You must be closer to grapple your opponent\.$|^Wouldn't it be better if you used a melee weapon\?$|^You can't fire .+\!$|^But your .+ isn't loaded\!$|^How can you poach if you are not hidden\?$|^You can not slam with that\!$|^It's best you not do that to .+\.$"
	if ("%Send.response" == "You aren't close enough to attack." || "%Send.response" == "You must be closer to use tactical abilities on your opponent." || "%Send.response" == "You must be closer to grapple your opponent.") then {
		gosub AdvanceMelee
		goto SendingAttack
	}
	action remove ^< .*$
	action remove ^The .* lands?
	action remove ^The .* lands? (a|an) (benign|brushing|gentle|glancing|grazing|harmless|ineffective|skimming|light|good|good|solid|hard|strong|heavy|very heavy|extremely heavy|powerful|massive|awesome|vicious|earth-shaking|demolishing|spine-rattling|devastating|overwhelming|obliterating|annihilating|cataclysmic|apocalyptic) (blow|hit|strike)
	action remove ^The .* lands? (a|an) (benign|brushing|gentle|glancing|grazing|harmless|ineffective|skimming|light|good|good|solid|hard|strong|heavy|very|extremely|powerful|massive|awesome|vicious|earth-shaking|demolishing|spine-rattling|devastating|overwhelming|obliterating|annihilating|cataclysmic|apocalyptic)
	return