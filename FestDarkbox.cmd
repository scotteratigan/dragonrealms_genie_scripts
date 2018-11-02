#REQUIRE Advance.cmd
#REQUIRE Cast.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Error.cmd
#REQUIRE Face.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Gouge.cmd
#REQUIRE Harness.cmd
#REQUIRE Information.cmd
#REQUIRE Loot.cmd
#REQUIRE Navigate.cmd
#REQUIRE Nounify.cmd
#REQUIRE Prepare.cmd
#REQUIRE Put.cmd
#REQUIRE Region.cmd
#REQUIRE Send.cmd
#REQUIRE Stow.cmd
#REQUIRE Trash.cmd
#REQUIRE Travel.cmd
#REQUIRE WaitSpelltime.cmd
#REQUIRE Warning.cmd

delay .01

# Without warning, the Darkbox simply vanishes.

#In case anyone was unsure, you ask the mage about teach or teaching for him to show you the alternative cast options
#https://elanthipedia.play.net/Grumpy_Mage_(1)

var FestDarkbox.junkNounList kelp|rockweed|sharkskin|tobacco|ocarina
var FestDarkbox.foodNounList beer|cheesecake|eyes|ham|mash|muffin|steak|taffy|venison|bloodgrog
var FestDarkbox.herbNounList root|flowers
var FestDarkbox.gemList agate|alexandrite|amber|amethyst|andalusite|aquamarine|bead|beryl|bloodgem|bloodstone|carnelian|chalcedony|chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|egg|eggcase|emerald|garnet|gem|glossy malachite|goldstone|granite|hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|onyx|opal|pearl|pebble|peridot|quartz|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon|thealstone
var FestDarkbox.junkClothList burlap|felt|linen|silk|cotton|wool
var FestDarkbox.sortaGoodJunkItems cambrinth cobra|cambrinth snake|cambrinth viper|cambrinth anklet|cambrinth armband|cambrinth ring|cambrinth earcuff|huntsman's axe|spiked axe|lilac pants|sapphire-blue pants|pearl-grey pants|goblin-hide pants|grey pants|acolyte's alb|wool cloak|white sundress|silk headscarf|wool breeches|woolen cap|orange shirt|silk shirt|black silk surcoat|white silk surcoat|silk sash|seal-pelt moccasins|lavender sundress|sharkskin boots|chocolate rose|green trousers|sun-kissed perfume|fang necklace|oravir nugget|copper nugget|platinum nugget|cambrinth coyote|alabaster deed|marble deed|schist deed|granite deed|gabbro deed|basalt deed|pumice deed|jade deed|andesite deed|felt jacket|wooden guava|gold nugget
#action put #echo >Log white Tickets: $1 when ^You pick up (\d+) Hollow Eve tickets\.$
action put #echo >Log white Item: $1 when ^You pick up (.+)\.$
action send stop play when ^You're already playing a song\!  You'll need to stop that one first\.$
var FestDarkbox.droppedItem
var FestDarkbox.haveTeeth 0
action var FestDarkbox.droppedItem $1 when ^Your (.+) falls to the ground\.$
#Your torn sharkskin falls to the ground.
put #script abort afk
gosub ClearHand both
if ("$SpellTimer.EyesoftheBlind.active" == "1") then gosub Release EOTB

if ("$zoneid" != "210") then {
	gosub Region
	if ("$region" != "Crossing") then gosub Travel 1
	gosub Navigate 1 fest
	gosub WaitEnterFest
}

Loop:
	if ("%FestDarkbox.droppedItem" != "") then {
		gosub Nounify %FestDarkbox.droppedItem
		var FestDarkbox.droppedItem 
		gosub Get %Nounify.noun
		if (%Get.success != 1) then {
			# If I failed here I likely need to pause for healing.
			pause 20
			gosub Get %Nounify.noun
		}
		# Going to gosub PlayedDarkbox so we can determine if the retreived item is junk or not.
		gosub PlayedDarkbox
	}
	# Clean-up section for grabbing stuff other players drop:
	if (matchre("$roomobjs", "\b(stone|tooth)\b")) then gosub Stow $1
	# Check for inability to stow items:
	if ("$righthand $lefthand" != "Empty Empty") then {
		put exit
		pause
		exit
	}
	if ("$SpellTimer.Devour.active" != "1") then {
		if (%FestDarkbox.haveTeeth == 1) then {
			gosub FestDarkboxTurnInTeeth
		}
		gosub FestCastDevour
	}
	if !contains("$roomobjs", "Darkbox") then gosub FindDarkbox
	gosub PlayDarkbox
	goto Loop

PlayDarkbox:
	# var FestDarkbox.itemID null
	# var FestDarkbox.itemDesc null
	# var FestDarkbox.itenNoun null
	
	put play darkbox
	wait
PlayedDarkbox:
	if ("$lefthand $righthand" == "Empty Empty") then return
	
	# Assumes we only have something in one hand.
	if ("$righthand" != "Empty") then {
		var FestDarkbox.itemID #$righthandid
		var FestDarkbox.itemDesc $righthand
		var FestDarkbox.itemNoun $righthandnoun
	}
	if ("$lefthand" != "Empty") then {
		var FestDarkbox.itemID #$lefthandid
		var FestDarkbox.itemDesc $lefthand
		var FestDarkbox.itemNoun $lefthandnoun
	}
	# Ok, we grabbed something...
	if (matchre("%FestDarkbox.itemNoun", "\b(%FestDarkbox.junkNounList|%FestDarkbox.foodNounList|%FestDarkbox.herbNounList)\b")) then {
		gosub Information Darkbox: junk - $righthand
		gosub Trash %FestDarkbox.itemID
		return
	}
	if (contains("coin|coins", "%FestDarkbox.itemNoun")) then {
		gosub Information Darkbox: coins.
		gosub Get my coin
		return
	}
	if (matchre("%FestDarkbox.itemDesc", "(small|bulging) pouch")) then {
		gosub Information Darkbox: tickets!
		gosub Open %FestDarkbox.itemID
		#gosub Get ticket from %FestDarkbox.itemID <- this was totally working for days and suddenly stopped...
		gosub Get ticket from my %FestDarkbox.itemDesc
		gosub Trash %FestDarkbox.itemID
		return
	}
	if ("%FestDarkbox.itemNoun" == "tooth") then {
		var FestDarkbox.haveTeeth 1
		gosub Information Darkbox: tooth.
		gosub Stow my tooth
		return
	}
	if (matchre("\b%FestDarkbox.itemNoun\b", "%FestDarkbox.gemList")) then {
		gosub Information Darkbox: standard gem.
		gosub Stow %FestDarkbox.itemID
		put fill my pouch with my rift
		return
	}
	if ("%FestDarkbox.itemNoun" == "cloth") then {
		if (matchre("%FestDarkbox.itemDesc", "%FestDarkbox.junkClothList")) then {
			gosub Information Darkbox: junk clothing, disarding.
			gosub Trash my cloth
			return
		}
		gosub Information Darkbox: potential good cloth: %FestDarkbox.itemDesc
		gosub Stow %FestDarkbox.itemID
		return
	}
	if (matchre("%FestDarkbox.itemDesc", "%FestDarkbox.sortaGoodJunkItems")) then {
		gosub Information Darkbox: sorta good item - %FestDarkbox.itemDesc, trashing.
		gosub Trash %FestDarkbox.itemID
		return
	}
	#Default action:
		gosub Warning Darkbox: new item - %FestDarkbox.itemDesc ( %FestDarkbox.itemID )
		gosub Stow %FestDarkbox.itemID
		return

# Currently Unused:
WaitLeaveFest:
	if ("$zoneid" != "210") then {
		pause .2
		return
	}
	pause .2
	goto WaitLeaveFest

WaitEnterFest:
	if ("$roomname" == "Paasvadh Forest, Clearing") then {
		pause .2
		return
	}
	pause .2
	goto WaitEnterFest

#WaitOnHealing:
#	gosub Navigate 210 clearing
#WaitingOnHealing:
#	if ("$SpellTimer.Devour.active" != "1") then gosub GoCastDevour
#	return
	#if ($bleeding == 0) then return
	#pause 5
	#put enc
	#goto WaitingOnHealing

FindDarkbox:
	if ("$darkboxroom" != "" && !contains("$darkboxroom", "$")) then gosub Navigate $zoneid $darkboxroom
	if (contains("$roomobjs", "Darkbox")) then return
	put .FestSearchFor Darkbox
	waiteval (contains("$roomobjs", "Darkbox"))
	pause .5
	return

FestDarkboxTurnInTeeth:
	gosub ClearHand both
	gosub Navigate 210 clearing
FestDarkboxTurningInTeeth:
	gosub Get my shark's tooth
	if ("%Get.success" == "0") then return
	gosub Give my shark's tooth to gnomish workman
	if ("%Give.success" == "0") then return
	goto FestDarkboxTurningInTeeth