#REQUIRE Send.cmd

gosub Perceive %0
exit

Perceive:
	var Perceive.target $0
	var Perceive.success 0
Perceiveing:
	gosub Send RT "perceive %Perceive.target" "^You reach out with your senses and see.*$" "^Something in the area is interfering with your ability to perceive power\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Perceive.success 1
	return


# PERCEIVE AREA - Checks the room for spells in effect.
# PERCEIVE SELF - Checks the spells in effect on you.
# PERCEIVE MANA - Checks the mana available to you.
# PERCEIVE ALL - Checks everything you are able to sense.
# 
# > perceive area
# You can't sense anything about the immediate area.
# Roundtime: 3 sec.
# 
# > perceive self
# You sense the Devour spell upon you, which will last until its power is depleted or for about thirty-two roisaen.
# Roundtime: 3 sec.
# 
# > perceive mana
# You reach out with your senses and see flaring streams of black Necromantic mana oozing through the area.
# Roundtime: 3 sec.
# 
# > perceive all (default)
# You reach out with your senses and see flaring streams of black Necromantic mana oozing through the area.
# You sense the Devour spell upon you, which will last until its power is depleted or for about thirty-two roisaen.
# Roundtime: 3 sec.