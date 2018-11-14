#REQUIRE Send.cmd

# Todo: add other options besides depart death

gosub Depart %0
exit

Depart:
	var Depart.command $0
	var Depart.success 0
Departing:
	gosub Send Q "depart %Depart.command" "^Bracing yourself for pain, you concentrate on the Spiteful Rebirth spell\.  Your unnatural nervous system fires .+ even in death, forming the spell pattern\." "^Feeling depressed\?  You'll have to die first before you can depart\.$" "WARNING MESSAGES"
	var Depart.response %Send.response
	if ("%Send.success" == "1") then {
		var Depart.success 1
		return
	}
	return

# Todo: ensure that Depart.success is set properly by above text. What does a fail look like?
# Also todo: set variables for the result - are you healed? are you standing? maybe not necessary.

# Bracing yourself for pain, you concentrate on the Spiteful Rebirth spell.  Your unnatural nervous system fires strongly even in death, forming the spell pattern.
# Your corpse begins to shake violently, its roiling flesh sealing up gaping wounds.  The magic forces its heart to beat, artificially mimicking the rhythms of life.  After a few seconds of torturous convulsions, you experience senses of dislocation and pain!  You immediately snap from your disembodied state back into your body, gasping for air as you weakly drag yourself to your feet.
# As sight floods back to your mortal eyes, you feel your memories blur and begin to dissipate like a dream.  Forcefully, you grasp and claw at your mind, snatching it back from the edge of death.  Your memories of Vigor and Rage of the Clans float away, despite all efforts to recover them.  Just a moment after registering disappointment, a leaden feeling hits your stomach and with it the memory of the magic is instantly back.
# 
# Bracing yourself for pain, you concentrate on the Spiteful Rebirth spell.  Your unnatural nervous system fires strongly even in death, forming the spell pattern.
# Your corpse begins to shake violently, sprouting new mass to replace its lost organs.  The magic forces its heart to beat, artificially mimicking the rhythms of life.  After a few seconds of torturous convulsions, you experience senses of dislocation and pain!  You immediately snap from your disembodied state back into your body, gasping for air as you weakly drag yourself to your feet.
# As sight floods back to your mortal eyes, you feel your memories blur and begin to dissipate like a dream.  Forcefully, you grasp and claw at your mind, snatching it back from the edge of death.  Your memories of Rage of the Clans float away, despite all efforts to recover them.  Just a moment after registering disappointment, a leaden feeling hits your stomach and with it the memory of the magic is instantly back.
# 

