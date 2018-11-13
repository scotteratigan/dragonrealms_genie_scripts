#REQUIRE CheckSRE.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Connect.cmd
#REQUIRE Depart.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE FestTrashOrKeep.cmd
#REQUIRE Get.cmd
#REQUIRE Info.cmd
#REQUIRE NavigateRoomName.cmd
#REQUIRE FestCastDevour.cmd

gosub FestSnakePit
exit

FestSnakePit:
	if ("$charactername" != "Rellie") then  {
		echo This script is for high level necromancers only!
		exit
	}
	gosub CheckSRE
	if (%CheckSRE.ready != 1) then {
		echo Not ready for snake pit yet.
		return
	}
	gosub Info
	if (%Info.baseCharisma > %Info.currentCharisma) then {
		echo Under effects of death sickness, aborting.
		return
	}
	if ("$SpellTimer.Devour.active" != "1") then gosub FestCastDevour
	gosub ClearHand both
	gosub Navigate 210 snake The Snake Pit
	gosub Get treasure
	pause
	if ($dead == 1) then {
		gosub Connect RellieDRF
		gosub Depart death
		pause
		if ($dead == 1) then {
			echo Failed to depart death?!
			put exit
			exit
		}
	}
	if ("$lefthand" != "Empty") then gosub FestTrashOrKeep left
	if ("$righthand" != "Empty") then gosub FestTrashOrKeep right
	gosub ClearHand both
	gosub FestCastDevour
	return


# baseStrength - 40
# currentStrength