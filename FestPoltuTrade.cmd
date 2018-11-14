#REQUIRE ClearHand.cmd
#REQUIRE CraftGetRasps.cmd
#REQUIRE CraftMakeBroadswords.cmd
#REQUIRE FestBoggleBlast.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE FestGivePoltuItems.cmd
#REQUIRE FestSnakePit.cmd
#REQUIRE FestSpinneret.cmd
#REQUIRE FestTurnInRasps.cmd
#REQUIRE Health.cmd
#REQUIRE Look.cmd
#REQUIRE Rub.cmd

gosub FestPoltuTrade
exit

FestPoltuTrade:
	gosub ClearHand both
	if ("$SpellTimer.Devour.active" != "1") then gosub FestCastDevour
	gosub Health
	if (%Health.poisoned == 0) then {
		gosub FestSpinneret
		goto FestPoltuTrade
	}
	gosub Rub my viper ring
	gosub Health
	if (%Health.poisoned == 0) then goto FestPoltuTrade
	gosub FestSnakePit
	gosub Look at my rasp
	if ("%Look.response" == "You see nothing unusual.") then {
		gosub FestGivePoltuItems rasp
		gosub ClearHand both
		gosub FestBoggleBlast
		goto FestPoltuTrade
	}
	gosub ClearHand both
	gosub FestBoggleBlast
	gosub CraftGetRasps
	#gosub CraftMakeBroadswords 3
	#if (%CraftMakeBroadswords.success == 0) then return
	#gosub FestGivePoltuItems broadsword
	goto FestPoltuTrade