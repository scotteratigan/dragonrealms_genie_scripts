#REQUIRE Numerify.cmd
#REQUIRE Prepare.cmd

# Used to check revivial power. Returns:
# .ready <- can you depart death, or not?
# .minutesUntilMax <- number (0-999?)
# .minutesUntilMaxText <- text (one hundred nineteen) as an example

gosub CheckSRE
exit

CheckSRE:
	# todo: get other SRE strings - missing at least 1
	action var CheckSRE.ready 1 when ^You have as much power as your state of being and knowledge of Thanatology allows\.$|^The power of your next rebirth will be enough to both resuscitate you and knit your wounds closed\.$|^The power of your next rebirth will be enough to resuscitate you with power left over\.$|^The power of your next rebirth will be barely sufficient to resuscitate you\.$
	action var CheckSRE.minutesUntilMaxText $1 when ^Your power has waned due to a recent resuscitation and will return to you in (.+) \w+\.$
	action var CheckSRE.minutesUntilMaxText zero;var CheckSRE.minutesUntilMax 0 when ^You have as much power as your state of being and knowledge of Thanatology allows\.$
	#The power of your next rebirth will be insufficient.  You would not survive another resuscitation attempt.
	var CheckSRE.ready 0
	gosub Prepare SRE
	var CheckSRE.success %Prepare.success
	pause .01
	action remove ^You have as much power as your state of being and knowledge of Thanatology allows\.$|^The power of your next rebirth will be enough to both resuscitate you and knit your wounds closed\.$
	if ("%CheckSRE.minutesUntilMaxText" != "zero") then {
		gosub Numerify %CheckSRE.minutesUntilMaxText
		var CheckSRE.minutesUntilMax %Numerify.value
	}
	echo CheckSRE.ready: %CheckSRE.ready
	echo CheckSRE.minutesUntilMaxText: %CheckSRE.minutesUntilMaxText
	echo CheckSRE.minutesUntilMax: %CheckSRE.minutesUntilMax
	return

# You play with the dead pattern in your mind, assessing your current state.
# The power of your next rebirth will be barely sufficient to resuscitate you.
# Your power has waned due to a recent resuscitation and will return to you in one hundred nineteen roisaen.
# 
# You play with the dead pattern in your mind, assessing your current state.
# The power of your next rebirth will be insufficient.  You would not survive another resuscitation attempt.
# Your power has waned due to a recent resuscitation and will return to you in one hundred nineteen roisaen.