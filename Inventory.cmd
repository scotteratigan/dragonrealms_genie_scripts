#REQUIRE Arrayify.cmd
#REQUIRE Send.cmd

# Usage:
# Basic Inventory, Inventory armor, Inventory weapon
# OR Inventory <container> set:
#	Inventory.list (a balaclava|some vambraces|some plate gauntlets|etc)
#	Inventory.maxIndex
# Inventory check:
#	Inventory.maxItemEstimate (50, 100, 150, 200, 250, 300, 350, 400, 450, 500)
# Inventory <belt|head|body>:
#	NOT WORKING
# Inventory slot - sets slot variables (integers that represent number of currently worn items in a given inventory slot):
#	Inventory.slot_on_the_body
#	Inventory.slot_on_the_back
#	Inventory.slot_around_the_waist
#	Inventory.slot_like_head_armor
#	Inventory.slot_over_the_shoulder
#	Inventory.slot_on_shoulders
#	Inventory.slot_like_pants
#	Inventory.slot_like_a_shirt
#	Inventory.slot_on_the_wrist
#	Inventory.slot_on_a_finger
#	Inventory.slot_on_the_feet
#	Inventory.slot_around_the_neck
#	Inventory.slot_attached_to_the_belt
#	Inventory.slot_like_arm_armor
#	Inventory.slot_like_leg_armor
#	Inventory.slot_on_an_ear
#	Inventory.slot_on_both_ears
#	Inventory.slot_on_an_ankle
#	Inventory.slot_on_the_hands
#	Inventory.slot_on_the_thigh
#	Inventory.slot_on_the_upper_arm
#	Inventory.slot_in/on_the_nose
#	Inventory.slot_over_the_left_eye
#	Inventory.slot_over_the_right_eye
#	Inventory.slot_tied_to_the_hair
#	Inventory.slot_placed_in_the_hair
#	Inventory.slot_as_a_shirt_with_armor
#	Inventory.slot_as_a_hand_weapon
#	Inventory.slot_as_an_elbow_weapon
#	Inventory.slot_as_a_knee_weapon
#	Inventory.slot_as_a_foot_weapon
#	Inventory.slot_as_a_left_arm_shield
#	Inventory.slot_as_a_parry_stick
#	Inventory.slot_on_the_head


# Options:
# To list contents of a container: "container name"
# To estimate the number of items on character: "check"
# To list worn items matching criteria: "armor|weapons|fluff|containers|combat"
# To list number of items worn in each slot: "slots"

#You are carrying between 0 and 50 items on you.
#You are carrying between 150 and 200 items on you.
#You are carrying between 250 and 300 items on you.
# Todo: get text for at item limit, and over item limit
# Todo: how to capture and stow inventory list so that we can actually reference the items?
# Todo: see how text is stored for container with contents inside a container (and so forth)
# todo: add 'inv search pouch'
# todo: add inv held


# Variables that are potentially created:
# Main variables:
#	Inventory.text
#	Inventory.lastType - internal, last inventory category type
#	Inventory.containerInventoried - full name of container that you last listed contents of
#	Inventory.maxItemEstimate - maximum possible number of items you are carrying. Estimate, may be higher than total by up to 49. (Game limitation).
#	Inventory.visibleItemCount - set when you call Inventory list (with RT), counts total number of items on character. (May underestimate items with unique coding like stackers, origami primers, and other items that have unique code that takes up more than one inventory slot. Also won't count items that don't appear as an item in inventory, like a "beard" or "mustache").


gosub Inventory %0
	echo Inventory.text is %Inventory.text
	echo Inventory.lastType is %Inventory.lastType
	echo Inventory.containerInventoried is %Inventory.containerInventoried
	echo Inventory.maxItemEstimate is %Inventory.maxItemEstimate
	echo Inventory.slot_in/onthenose is %Inventory.slot_in/onthenose
	echo Inventory.fullText is %Inventory.fullText
	echo Inventory.visibleItemCount is %Inventory.visibleItemCount
	echo Inventory.leftHand is %Inventory.leftHand
	echo Inventory.rightHand is %Inventory.rightHand
	echo Inventory.list is %Inventory.list
	echo Inventory.maxIndex is %Inventory.maxIndex
	exit

Inventory:
	var Inventory.option $0
	var Inventory.text 
	var Inventory.list 
	var Inventory.maxIndex 0
	var Inventory.worn 
	var Inventory.containerInventoried 
	# Action for item count estimate:
		action var Inventory.maxItemEstimate $1 when ^You are carrying between \d+ and (\d+) items on you\.$
	# Action for generic 'inventory' command:
		action var Inventory.worn $1 when ^You are wearing (.+)\.$
	# Actions for listing inventory inside a container:
		action var Inventory.lastType $1;action (InventoryContainerList) on when ^All of your (.+):$
		action (InventoryContainerList) var Inventory.text %Inventory.text|$1 when ^  (.*)$
		action (InventoryContainerList) off
		action var Inventory.lastType container;var Inventory.containerInventoried $1;action (InventoryContainerList) on when ^Inside the (.+), you see:
	# Action to set the slot variables (Inventory.slot_as_a_knee_weapon 0/1 for instance):
		action eval Inventory.temp replace("$1", " ", "_");var Inventory.slot_%Inventory.temp $2 when ^Items worn (.+):\s+(\d+)/\d+$
	# Actions used for inventory list which grabs your entire inventory:
		action var Inventory.visibleItemCount 0;var Inventory.fullText ;action (InventoryFullListing) on when ^You take a moment and rummage about your person, taking stock of your possessions\.\.\.$
		action (InventoryFullListing) var Inventory.fullText %Inventory.fullText|$1;math Inventory.visibleItemCount add 1 when ^     +\-(.+)$|^  +([\S]+)$
		# Note: the following trigger detects the end of an inventory command and shuts off BOTH inventory action groups:
		action action (InventoryContainerList) off;action (InventoryFullListing) off when ^\[Type INVENTORY HELP for more options\]$
	# Actions for inventory held, set the .rightHand and .leftHand variables:
		action var Inventory.rightHand Empty;var Inventory.leftHand Empty when ^Both of your hands are empty\.$
		action var Inventory.rightHand $1;var Inventory.leftHand $2 when ^In your right hand, you are carrying (.+), and in your left hand, you are carrying (.+)\.$
		action var Inventory.rightHand Empty;var Inventory.leftHand $1 when ^In your left hand, you are carrying (.+)\.$
		action var Inventory.rightHand $1;var Inventory.leftHand Empty when ^In your right hand, you are carrying ([\w\-' ]+)\.$
Inventorying:
	gosub Send Q "inventory %Inventory.option" "^\[Type INVENTORY HELP for more options\]$" "^You'll need to be holding .+ to do that\!$|^  INV HELD   - Shows you what you have in your hands\.$"
	if ("%Inventory.text" != "") then {
		eval Inventory.text replacere("%Inventory.text", "^\|", "")
	}
	if ("%Inventory.fullText" != "") then {
		eval Inventory.fullText replacere("%Inventory.fullText", "^\|", "")
	}
	if ("%Inventory.worn" != "") then {
		gosub Arrayify %Inventory.worn
		var Inventory.list %Arrayify.list
	}
	if ("%Inventory.list" == "") then var Inventory.list %Inventory.text
	eval Inventory.maxIndex count("%Inventory.list", "|")
	action remove ^You are carrying between \d+ and (\d+) items on you\.$
	action remove ^  (.*)$
	action remove ^\[Type INVENTORY HELP for more options\]$
	action remove ^You are wearing (.+)\.$
	action remove ^All of your (\w+):$
	action remove ^Inside the (.+), you see:
	action remove ^Items worn (.+):\s+(\d+)/\d+$
	action remove ^You take a moment and rummage about your person, taking stock of your possessions\.\.\.$
	action remove ^     +\-(.+)$|^  +([\S]+)$
	action remove ^Both of your hands are empty\.$
	action remove ^In your right hand, you are carrying (.+), and in your left hand, you are carrying (.+)\.$
	action remove ^In your left hand, you are carrying (.+)\.$
	action remove ^In your right hand, you are carrying ([\w\-' ]+)\.$
	return

#	Slot name 			how to access (command, case sensitive)		Text that appears first. (Note, only appears if you have an item of that type worn)
#	Misc				body 						All of your items worn on the body:
#	Back 				back 						All of your items worn on the back:
#	Waist 				waist 						All of your items worn around the waist:
#	Head 				head 						All of your items worn like head armor:
#	Over the shoulder 	shoulder 					All of your items worn over the shoulder:
#	On shoulders 		on shoulders				All of your items worn over the shoulder:
#	Pants 				pants 						All of your items worn like pants:
#	Shirt 				shirt 						All of your items worn like a shirt:
#	Wrist 				wrist 						All of your items worn on the wrist:
#	Finger 				finger 						All of your items worn on a finger:
#	Feet 				feet 						All of your items worn on the feet:
#	Neck 				neck 						All of your items worn around the neck:
#	Belt 				belt 						All of your items worn attached to the belt:
#	Arm armor 			arm 						All of your items worn like arm armor:
#	Leg armor 			leg armor 					All of your items worn like leg armor: (note: doesn't show if other worn area protects, like hauberk)
#	Ear 				ear 						All of your items worn on an ear:
#	Ears 				ears 						All of your items worn on both ears:
#	Ankle 				ankle 						All of your items worn on an ankle:
#	Hands 				hands 						All of your items worn on the hands:
#	Thigh 				thigh
#	Upper arm 			upper arm 					All of your items worn on the upper arm:
#	Nose 				nose
#	Left eye 			left eye
#	Right eye 			right eye
#	Tied to hair 		tied to hair
#	Placed in hair 		placed in hair
#	Shirt with armor 	shirt with armor 			All of your items worn as a shirt with armor:
#	Hand weapon 		hand weapon 				All of your items worn as a hand weapon:
#	Elbow weapon 		elbow weapon 				All of your items worn as an elbow weapon:
#	Knee weapon 		knee weapon 				All of your items worn as a knee weapon:
#	Foot weapon 		foot weapon
#	Left arm shield 	left arm shield 			All of your items worn as a left arm shield:
#	Parry stick 		parry stick 				All of your items worn as a parry stick:
#	Head (non-armor)	'head '						All of your items worn on the head: (note the trailing space)