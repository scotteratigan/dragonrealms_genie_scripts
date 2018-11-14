#REQUIRE Send.cmd
#REQUIRE Arrayify.cmd

gosub Health
exit

Health:
	var Health.bodyPartsList head|left eye|right eye|neck|chest|abdomen|back|left arm|right arm|left hand|right hand|left leg|right leg|tail|skin
	action var Health.leechList ;var Health.leechArray ;var Health.bleederArray ;var Health.bleeding 0;var Health.poisoned 0 when ^Your body feels.*$|^Your spirit feels.*$
	action var Health.leechList $1 when ^You have (.*leech.*)\.$
	action var Health.bleederArray %Health.bleederArray|$1 when ^\s+(%Health.bodyPartsList)
	action var Health.poisoned 1 when ^You have.*poison
	gosub Send Q "health" "^Your body feels.*$|^Your spirit feels.*$" "FAIL MESSAGES" "WARNING MESSAGES"
	action remove ^Your body feels.*$|^Your spirit feels.*$
	action remove ^You have (.*leech.*)\.$
	action remove ^\s+(%Health.bodyPartsList)
	action remove ^You have.*poison
	if ("%Health.bleederArray" != "") then {
		var Health.bleeding 1
		eval Health.bleederArray replacere("%Health.bleederArray", "^\|", "")
	}
	if ("%Health.leechList" != "") then {
		gosub Arrayify %Health.leechList
		var Health.leechArray %Arrayify.list
	}
	return

# Todo: add wound detection, lodged item detection, bleeder detection

# Your body feels slightly battered.
# Your spirit feels full of life.
# You are slightly fatigued.
# You have some minor abrasions to the right arm, some minor abrasions to the left arm.
# 
# You have a small black sand leech on your left arm, a small black sand leech on your right arm.

# Your body feels at full strength.
# Your spirit feels full of life.
# You feel somewhat tired and seem to be having trouble breathing.

#Bleeding
#            Area       Rate              
#-----------------------------------------
#       right arm       (tended)
#       right leg       (tended)
#        left leg       (tended)
#   inside r. arm       slight
#   inside r. leg       slight
#   inside l. leg       light
#XML-<output class=""/>-XML

#       right arm       light(tended)
#       right leg       slight(tended)

#action var TendedBleederList %TendedBleederList|$1 when ^\s+(%BodyPartList)\s+(slight|light|moderate|bad|very bad|heavy|very heavy|severe|very severe|profuse|very profuse|gushing|massive stream|uncontrollable|unbelievable|beyond measure|death awaits)\(tended\)


# Percentage	Combat Message	HEALTH Message
# >100%	invigorated	incredibly full of strength
# 100%	none	full strength
# 99%-90%	bruised	slightly battered
# 89%-80%	hurt	somewhat battered
# 79%-70%	battered	battered
# 69%-60%	beat up	beat up
# 59%-50%	very beat up	very beat up
# 49%-40%	badly hurt	extremely beat up
# 39%-30%	very badly hurt	bad shape
# 29%-20%	smashed up	very bad shape
# 19%-10%	terribly wounded	extremely bad shape
# 9%-1%	near death	death's door
# <1%	in death's grasp	dead

# Your body feels at full strength.
# Your spirit feels full of life.
# You have a critically strong nerve poison.