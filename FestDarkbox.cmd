#REQUIRE Put.cmd
#REQUIRE Send.cmd
#REQUIRE Stow.cmd
#REQUIRE Get.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Navigate.cmd
#REQUIRE Trash.cmd
#REQUIRE Region.cmd
#REQUIRE Travel.cmd
#REQUIRE Nounify.cmd
#REQUIRE Information.cmd
#REQUIRE Warning.cmd
#REQUIRE Error.cmd
#REQUIRE Advance.cmd
#REQUIRE Face.cmd
#REQUIRE Prepare.cmd
#REQUIRE WaitSpelltime.cmd
#REQUIRE Harness.cmd
#REQUIRE Cast.cmd
#REQUIRE Gouge.cmd

delay .01

#In case anyone was unsure, you ask the mage about teach or teaching for him to show you the alternative cast options
#https://elanthipedia.play.net/Grumpy_Mage_(1)

var FestDarkbox.junkNounList kelp|rockweed|sharkskin|tobacco
var FestDarkbox.foodNounList beer|cheesecake|eyes|ham|mash|muffin|steak|taffy|venison|bloodgrog
var FestDarkbox.herbNounList root|flowers
var FestDarkbox.gemList agate|alexandrite|amber|amethyst|andalusite|aquamarine|bead|beryl|bloodgem|bloodstone|carnelian|chalcedony|chrysoberyl|chrysoprase|citrine|coral|crystal|diamond|diopside|egg|eggcase|emerald|garnet|gem|glossy malachite|goldstone|granite|hematite|iolite|ivory|jade|jasper|kunzite|lapis lazuli|malachite stone|minerals|moonstone|morganite|onyx|opal|pearl|pebble|peridot|quartz|ruby|sapphire|spinel|star-stone|sunstone|talon|tanzanite|tooth|topaz|tourmaline|tsavorite|turquoise|zircon|thealstone
var FestDarkbox.junkClothList burlap|felt|linen|silk|cotton|wool
var FestDarkbox.sortaGoodJunkItems cambrinth cobra|cambrinth snake|cambrinth viper|cambrinth anklet|cambrinth armband|cambrinth ring|cambrinth earcuff|huntsman's axe|spiked axe|lilac pants|sapphire-blue pants|pearl-grey pants|goblin-hide pants|grey pants|acolyte's alb|wool cloak|white sundress|silk headscarf|wool breeches|woolen cap|orange shirt|silk shirt|black silk surcoat|white silk surcoat|silk sash|seal-pelt moccasins|lavender sundress|sharkskin boots|chocolate rose
#action put #echo >Log white Tickets: $1 when ^You pick up (\d+) Hollow Eve tickets\.$
action put #echo >Log white Item: $1 when ^You pick up (.+)\.$
action send stop play when ^You're already playing a song\!  You'll need to stop that one first\.$
var FestDarkbox.droppedItem
action var FestDarkbox.droppedItem $1 when ^Your (.+) falls to the ground\.$
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
		# Pause in case I need to wait for healing
		pause 20
		gosub ClearHand both
		gosub Nounify %FestDarkbox.droppedItem
		# GetNoun sets the noun to ItemString
		gosub Get %Nounify.noun
		# Going to gosub PlayedDarkbox so we can determine if the retreived item is junk or not.
		gosub PlayedDarkbox
	}
	if ("$righthand $lefthand" != "Empty Empty") then {
		put exit
		pause
		exit
	}
	if ("$SpellTimer.Devour.active" != "1") then gosub GoCastDevour
	if !contains("$roomobjs", "Darkbox") then gosub FindDarkbox
	gosub PlayDarkbox
	goto Loop

PlayDarkbox:
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

GoCastDevour:
	gosub Navigate 210 rats
	gosub WaitOnMob
	gosub Prepare Devour 50
	gosub Face next
	gosub AdvanceMelee
Killing:
	gosub Gouge
	if matchre("$roomobjs", "(\S+) which appears dead") then {
		# Todo: create perform verb/script, add this in:
		gosub Send RT "perform consume on $1" "^\[?\(?Roundtime:" "^This ritual may only be performed on a corpse\.$"
		gosub Harness 50
		gosub WaitSpelltime 18
		gosub Cast
		return
	}
	goto Killing

WaitOnMob:
	if ($monstercount > 0) then return
	put wait
	pause
	goto WaitOnMob

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