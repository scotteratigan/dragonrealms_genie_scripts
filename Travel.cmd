#REQUIRE ClearHand.cmd
#REQUIRE Faldesu.cmd
#REQUIRE Info.cmd
#REQUIRE Information.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE Region.cmd
#REQUIRE Release.cmd
#REQUIRE Segoltha.cmd
#REQUIRE Stand.cmd
#REQUIRE WaitStun.cmd
# Todo: move wealth check to each leg of the trip... if you plan ahead you won't lose time.. if you forget, it's easy to get money
# Downside is you might not have money in a given bank... yeah, better start the trip with money... fml
# Todo: switch to using FC bank at the beginning of the trip because otherwise I get fucked...

gosub Travel %0
exit

Travel:
	eval Travel.destinationZone tolower("$1")
	eval Travel.destinationRoom tolower("$2")
	# Note: this list is also in Travel.cmd, be sure to make any updates there as well.
	if (contains("fest|festival", "%Travel.destinationZone")) then var Travel.destinationZone 210
	if (contains("crossing|xing", "%Travel.destinationZone")) then var Travel.destinationZone 1
	if (contains("temple", "%Travel.destinationZone")) then var Travel.destinationZone 2a
	if (contains("tiger clan", "%Travel.destinationZone")) then var Travel.destinationZone 4a
	if (contains("north gate", "%Travel.destinationZone")) then var Travel.destinationZone 6
	if (contains("ntr", "%Travel.destinationZone")) then var Travel.destinationZone 7
	if (contains("stoneclan", "%Travel.destinationZone")) then var Travel.destinationZone 10
	if (contains("guardians", "%Travel.destinationZone")) then var Travel.destinationZone 11
	if (contains("abbey", "%Travel.destinationZone")) then var Travel.destinationZone 12a
	if (contains("dirge", "%Travel.destinationZone")) then var Travel.destinationZone 13
	if (contains("faldesu", "%Travel.destinationZone")) then var Travel.destinationZone 14c
	if (contains("riverhaven", "%Travel.destinationZone")) then var Travel.destinationZone 30
	if (contains("rossmans", "%Travel.destinationZone")) then var Travel.destinationZone 34
	if (contains("theren|therenborough", "%Travel.destinationZone")) then var Travel.destinationZone 42
	if (contains("leth deriel", "%Travel.destinationZone")) then var Travel.destinationZone 61
	if (contains("shard", "%Travel.destinationZone")) then var Travel.destinationZone 67
	if (contains("wyverns|wyvernmountains", "%Travel.destinationZone")) then var Travel.destinationZone 70
	if (contains("ratha", "%Travel.destinationZone")) then var Travel.destinationZone 90
	if (contains("mer'kresh|merkresh", "%Travel.destinationZone")) then var Travel.destinationZone 107
	if (contains("m'riss|mriss", "%Travel.destinationZone")) then var Travel.destinationZone 108
	if (contains("hib|hibarnhvidar|hibbles", "%Travel.destinationZone")) then var Travel.destinationZone 116
	if (contains("raven's point|ravens point", "%Travel.destinationZone")) then var Travel.destinationZone 123
	if (contains("boarclan", "%Travel.destinationZone")) then var Travel.destinationZone 127
	if (contains("ainghazal", "%Travel.destinationZone")) then var Travel.destinationZone 114
	if (contains("hibarnhvidar|hibbles", "%Travel.destinationZone")) then var Travel.destinationZone 116
	if (contains("maulers|zombies|head-splitters|stompers", "%Travel.destinationZone")) then {
		var Travel.destinationZone 127
	}
	# This is necessary because wyvern mountAINs contain AIN (ghazal). This is a GREAT way to die.
	if ("%Travel.destinationZone" == "ain") then var Travel.destinationZone 114
	if (contains("fang cove|arch", "%Travel.destinationZone")) then var Travel.destinationZone 150

TravelPrepare:
	if ("$SpellTimer.UniversalSolvent.active" == "1") then gosub Release USOL
	if ("$lefthand $righthand" != "Empty Empty") then gosub ClearHand both
	gosub Region %Travel.destinationZone
	if (contains("|150|210|", "|$zoneid|")) then {
		if ("%Travel.destinationZone" != "$zoneid") then {
			# Note: an && if statement didn't work for some reason. Nesting works fine. Ugh.
			gosub Navigate $zoneid leave
			gosub Region %Travel.destinationZone
		}
		
	}
	if ("%Region.region" == "%Region.destinationRegion") then goto TravelToFinalDestination
	if ("%Travel.destinationZone" == "150") then goto TravelToFinalDestination
	if ("%Region.region" == "Aesry") then {
		if ("%Region.destinationRegion" == "Crossing") then {
			#var MinimumKronars 35
			gosub TravelAesryToFangCove
			gosub TravelFangCoveToLeth
			gosub TravelLethToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelAesryToFangCove
			gosub TravelFangCoveToLeth
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Crossing") then {
		if ("%Region.destinationRegion" == "Aesry") then {
			# todo: what does aesry boat cost? #var MinimumLirums ???
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToAesry
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelCrossingToLeth
			goto TravelToFinalDestination 
		}
		if ("%Region.destinationRegion" == "Ratha") then {
			gosub TravelCrossingToFangCove
			gosub TravelFangCoveToRatha
		}
		if ("%Region.destinationRegion" == "Riverhaven") then {
			#var MinimumLirums 30
			gosub TravelCrossingToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			var MinimumKronars 35
			gosub TravelCrossingToLeth
			gosub TravelLethToShard
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Kresh") then {
		if ("%Region.destinationRegion" == "Mriss") then {
			gosub Navigate 107 113
			put .ferry
			waitforre ^FINISHED RIDING FERRY
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Mriss") then {
		if ("%Region.destinationRegion" == "Kresh") then {
			gosub Navigate 108 151
			put .ferry
			waitforre ^FINISHED RIDING FERRY
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Leth") then {
		if ("%Region.destinationRegion" == "Ain") then {
			gosub TravelLethToAin
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Crossing") then {
			gosub Info
			if ("%Info.guild" == "Thief") then gosub ThiefLethToCrossing
			else gosub TravelLethToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Ratha") then {
			gosub TravelLethToRatha
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			gosub TravelLethToShard
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Riverhaven") then {
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Ain") then {
		if ("%Region.destinationRegion" == "Crossing") then {
			gosub TravelAinToLeth
			gosub TravelLethToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "FangCove") then {
			gosub Navigate 114 176
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelAinToLeth
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Ratha") then {
			gosub TravelAinToLeth
			gosub TravelLethToRatha
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Riverhaven") then {
			gosub TravelAinToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			gosub TravelAinToShard
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelAinToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Ratha") then {
		if ("%Region.destinationRegion" == "Ain") then {
			gosub TravelRathaToLeth
			gosub TravelLethToAin
		}
		if ("%Region.destinationRegion" == "Crossing") then {
			gosub TravelRathaToFangCove
			gosub TravelFangCoveToLeth
			gosub TravelLethToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Fang Cove") then {
			gosub Navigate 90 841
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelRathaToFangCove
			gosub TravelFangCoveToLeth
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Riverhaven") then {
			gosub TravelRathaToFangCove
			gosub TravelFangCoveToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			gosub TravelRathaToFangCove
			gosub TravelFangCoveToLeth
			gosub TravelLethToShard
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelRathaToFangCove
			gosub TravelFangCoveToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Riverhaven") then {
		if ("%Region.destinationRegion" == "Aesry") then {
			gosub TravelRiverhavenToAesry
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Crossing") then {
			#var MinimumLirums 30
			gosub TravelRiverhavenToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			#var MinimumKronars 35
			gosub TravelRiverhavenToCrossing
			gosub TravelCrossingToLeth
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			gosub TravelRiverhavenToCrossing
			gosub TravelCrossingToLeth
			gosub TravelLethToShard
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Shard") then {
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelShardToLeth
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Crossing") then {
			gosub TravelShardToLeth
			gosub TravelLethToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Aesry") then {
			#var MinimumKronars 35
			#var MininmumLirums 30
			gosub TravelShardToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToAesry
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Riverhaven") then {
			gosub TravelShardToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Theren") then {
			gosub TravelShardToLeth
			gosub TravelLethToCrossing
			gosub TravelCrossingToRiverhaven
			gosub TravelRiverhavenToTheren
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Ain") then {
			#var MinimumDokoras 31
			gosub Navigate 123 174
			gosub RunScript ferry
			goto TravelToFinalDestination
		}
	}
	if ("%Region.region" == "Theren") then {
		if ("%Region.destinationRegion" == "Riverhaven") then {
			gosub TravelTherenToRiverhaven
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Crossing") then {
			gosub TravelTherenToRiverhaven
			gosub TravelRiverhavenToCrossing
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Leth") then {
			gosub TravelTherenToRiverhaven
			gosub TravelRiverhavenToCrossing
			gosub TravelCrossingToLeth
			goto TravelToFinalDestination
		}
		if ("%Region.destinationRegion" == "Shard") then {
			gosub TravelTherenToRiverhaven
			gosub TravelRiverhavenToCrossing
			gosub TravelCrossingToLeth
			gosub TravelLethToShard
			goto TravelToFinalDestination
		}
	}
	gosub Error No defined route from %Region.region to %Region.destinationRegion.
	return

#################################### Beginning of Travel Gosubs ####################################

TravelAesryToFangCove:
	gosub Navigate 99 392
	return

TravelLethToAin:
	gosub Navigate 112 98
	gosub RideFerry
	return

TravelShardToAin:
	gosub Navigate 123 174
	gosub RideFerry
	gosub RideFerry
	return

TravelAinToLeth:
	gosub Navigate 114 1
	gosub RideFerry
	return

TravelAinToShard:
	gosub Navigate 114 4
	gosub RideFerry
	return

TravelCrossingToFangCove:
	gosub Navigate 1 702
	return

TravelCrossingToLeth:
	gosub Info
	if ("%Info.guild" == "Thief" && %Info.circle >= 5) then {
		gosub Information Taking thief passage from Crossing to Leth.
		gosub Navigate 1 700
		gosub Navigate 1a 23
		return
		}
	}
	if ($Athletics.Ranks > 450) then {
		gosub Navigate 4a 73
		pause .5
		gosub Segoltha south
		return
	}
	#var MinimumKronars 35
	gosub Navigate crossing ferry
	gosub RideFerry
	return

TravelCrossingToRiverhaven:
	if ($Athletics.Ranks > 200) then {
		gosub Navigate 7 197
		gosub Faldesu north
		return
	}
	#var minimumLirums 30
	gosub Navigate 7 81
	gosub Information Not enough athletics to swim the Faldesu, taking ferry instead.
	gosub RideFerry
	return

TravelFangCoveToLeth:
	gosub Navigate 150 2
	gosub RideFerry Leth
	return

TravelFangCoveToRatha:
	gosub Navigate 150 213
	pause .5
	if ("$zoneid" == "90") then return
	gosub Move go meeting portal
	gosub Navigate 150 2
	gosub RideFerry Ratha
	return

TravelLethToCrossing:
	gosub Info
	if ("%Info.guild" == "Thief" && %Info.circle >= 5) then {
		# Todo: use knowledge of passages?
		# action var TakePassage 1;echo Swt, will take the secret passage to Leth! when ^Recalling with vivid detail the \"accident\" that befell the last individual to point out a Guild secret, you reconsider\.$
		gosub Navigate 60 108
		gosub Navigate 1a 6
		# Third nav not technically necessary, but it makes more sense than pausing in a room where mobs spawn:
		gosub Navigate 1 42
		return
	}
	if ($Athletics.Ranks > 450) then {
		gosub Navigate 60 109
		pause .5
		gosub Segoltha north
		return
	}
	#if %Kronars < 35 then {
	gosub Navigate 60 42
	gosub RideFerry
	return	

TravelLethToRatha:
	# Todo - this is not actually done yet
	gosub Navigate 58 45
	gosub RideFerry Ratha
	return

TravelRathaToLeth:
	gosub Navigate 90 834
	# TODO: finish coding here
	return

TravelLethToShard:
	# Previous lower limit was 530. Zaul can make this climb unaided by rope with 475 ranks. 40 str, 103 effective agility
	if $Athletics.Ranks >= 475 then goto ClimbLethToShard
	gosub Navigate 62 3
	gosub RideFerry
	return
ClimbLethToShard:
	gosub Navigate 62 155
	return

TravelRathaToFangCove:
	gosub Navigate 90 841
	return

TravelRiverhavenToAesry:
	gosub Navigate 30 104
	gosub RideFerry
	return

TravelRiverhavenToCrossing:
	if ($Athletics.Ranks > 200) then {
		gosub Navigate 31 79
		gosub Faldesu south
		return
	}
	gosub Information Not enough ranks to swim the Faldesu, so we're taking the ferry.
	gosub Navigate 30 103
	gosub RideFerry
	return

TravelRiverhavenToTheren:
	if $Athletics.Ranks > 200 then {
		gosub Navigate 33a 48
		gosub Navigate 34 137
		return
	}
	gosub Navigate 30 99
	gosub RideFerry
	return

TravelShardToLeth:
	# Previous lower limit was 530. Zaul can make this climb unaided by rope with 475 ranks. 40 str, 103 effective agility. Limit is probably even lower with rope.
	if ($Athletics.Ranks >= 475) then {
		gosub Navigate 65 44
		return
	}
	if ($Athletics.Ranks > 150) then {
		gosub Navigate 65 22
		gosub Move go gap
		waitforre ^You are stunned\!
		pause
		gosub WaitStun
		gosub Stand
		if ($monstercount == 0 && $First_Aid.Ranks > 15) then {
			put tend my head
			wait
		}
		return
	}
	gosub Navigate 66 156
	gosub RideFerry
	return

TravelTherenToRiverhaven:
	if ($Athletics.Ranks < 200) then {
		gosub Information Not enough Athletics to swim to Riverhaven. $Athletics.Ranks / 200.
		goto TravelByBargeTherenToRiverhaven
	}
	if ($Evasion.Ranks < 150) then {
		gosub Information Not enough Evasion to survive a likely orc attack, taking the barge.
		goto TravelByBargeTherenToRiverhaven
	}
	gosub Information Taking the fast route to Riverhaven, watch out for orcs!
	gosub Navigate 40 213
	gosub Navigate 34 15
	return
TravelByBargeTherenToRiverhaven:
	gosub Navigate 40 36
	gosub RideFerry
	gosub Navigate 30 8
	return

TravelToFinalDestination:
	if ("$zoneid-$roomid" == "%Travel.destinationZone-%Travel.destinationRoom") then return
	gosub Navigate %Travel.destinationZone %Travel.destinationRoom
	if ("$zoneid" != "%Travel.destinationZone") then {
		gosub Error Travel did not take me to proper zone.
		return
	}
	if ("%Travel.destinationRoom" != "" && "$roomid" != "%Travel.destinationRoom") then {
		if (matchre("%Travel.destinationRoom", "\d+")) then {
			# Ok, if we specified a room, we aren't in the room, and the specified room is a number, throw an error:
			gosub Error Travel did not take me to the proper room.
			return
		}
	}
	gosub Information Travel completed!
	return

RideFerry:
	echo TODO: port ferry script to this format!
	return