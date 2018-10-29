#REQUIRE Send.cmd

gosub Khri %0
exit

# Todo: get rest of khri messages?
# Create a list of active khri? (Probably not, would duplicate the Spelltimer plugin)

# Starting Khri messages:
# Avoidance: Taking a deep breath, you focus on making your mind and body one, your mental discipline trained on quickly noticing, analyzing, and dodging approaching threats.
# Cunning: Your dedicated training lends you grace in both mind and body, allowing you to easily escape binding situations.
# Darken: Focusing your mind, you look around yourself to find the subtle differences lurking in the shadows nearby.  After several deep breaths, your senses have attuned themselves to finding the best hiding spots.
# Eliminate: Honing your mind and body to a single purpose, you prepare to execute the perfect strike against a black goblin, clearly noticing a weak spot. (No RT message)
# Elusion: Purging yourself of all distractions and extraneous thoughts, you allow your mind and body to become one, becoming preternaturally aware of threats around you and the best ways to defend yourself.
# Flight: Knowing that a dose of paranoia is healthy for any aspiring Thief, your mind fixates on every possible avenue of escape available to you.
# Focus: With deep breaths, you recall your training and focus your mind to hone in on improving your physical dexterity.
# Hasten: Centering your mind, you allow your practiced discipline to spread throughout your body, making thought and motion one.
# Plunder: Your hand twitches slightly in anticipation as you focus your mind towards relieving others of their hard earned possessions.
# Prowess: Remembering the mantra of mind over matter, you let your dedicated focus seep into your muscles.  The sensation of believing that your enemies will tremble at the mere thought of you translates from your every movement.
# Safe: With but a quick thought, your hands steady and your mind gears itself to the purpose of getting into what others want you out of.
# Silence: Turning inwards, you find the still silent spot within you.  Focusing on that point, you allow the silence to spread gently through your body and then out into the world, until you fade away from the world itself.
# Steady: Willing your body to meet the heightened functionality of your mind, you feel your motions steady considerably.
# Strike: You calm your body and mind, recalling your training on how to seek the vital part of any opponent.  Wrapping yourself in this cool composure, your eyes quickly become drawn to exposed weaknesses around you.
# Terrify: Preparing your voice, you concentrate on projecting horrifying whispers at a foe.

# Stopping Messages:
# Generic: You attempt to relax your mind from some of its meditative states.
# Avoidance: Your concentration runs out, and your rapid analysis of incoming threats ceases.
# Cunning: Your preternatural ability to escape binding situations ceases.
# Darken: You are unable to maintain your focus on the shadows around you, and your knowledge of better hiding places subsides.
# Eliminate: Your concentration fails, as you lose focus on your target. (note that this is timed, not the result of a command)
# Elusion: You are no longer able to keep your thoughts free from distraction, and your heightened ability to avoid attacks and fight unarmed ceases.
# Flight: You feel mentally fatigued as your heightened paranoia ceases to enhance your knowledge of nearby escape routes.
# Focus: Your focused mind falters, and you feel downright clumsy by comparison.
# Hasten: Your concentration fails, and you feel your body perceptibly slow.
# Plunder: Your hands feel more clumsy as your intuition on how and when to relieve others of their possessions wanes.
# Prowess: You feel your muscles relax as you settle into a less threatening demeanor.
# Safe: Your hands no longer feel quite as steady as your grasp on the meditation fails.
# Silence: Your inner silence is lost to the noise and motion of the world around you and you feel your ability to blend in with your surroundings fade.
# Steady: The steadying influence your mind was exerting on your self fades away as you lose concentration upon it.
# Strike: Your cool composure fades, and with it your heightened knowledge of enemies' weak points.
# Terrify: Your focus slips and you feel less horrifying.

Khri:
	var Khri.commmand $0
	var Khri.success 0
Khriing:
	gosub Send RT "khri %Khri.commmand" "^Roundtime: \d+ sec\.$|^Honing your mind and body to a single purpose, you prepare to execute the perfect strike against .+, clearly noticing a weak spot\.$|^You attempt to relax your mind from all of its meditative states\.$|^From the (Subtlety|Finesse|Potence) tree,.*$|^You have \d+ available slots?\.$" "^Nothing happens\.$|^You are not trained in the .+ meditation\.$|^You have not recovered from your previous use of the .+ meditation\.$" "^You're already using the .+ meditation\.$|^You would need to start .+ before you could stop it\.$|^You attempt to blend a number of meditations to start simultaneously, but you feel your skill is lacking to complete them all\.$"
	if ("%Send.success" == "1") then var Khri.success 1
	return