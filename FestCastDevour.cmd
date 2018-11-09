#REQUIRE Cast.cmd
#REQUIRE Face.cmd
#REQUIRE Harness.cmd
#REQUIRE Loot.cmd
#REQUIRE NavigateRoomName.cmd
#REQUIRE Perform.cmd
#REQUIRE Prepare.cmd
#REQUIRE Target.cmd
#REQUIRE WaitMonstercount.cmd
#REQUIRE WaitSpelltime.cmd

gosub FestCastDevour
exit

FestCastDevour:
	# Note: this method doesn't rely on hard-coding room numbers, but also won't move if unnecessary.
	# The entire hunting area shares a room name, but in this case any room is fine.
	# Alternately, you could match room description which is more likely to be unique.
	put set roomname
	wait
	gosub NavigateRoomName 210 rats The Massive Arachnid, Haemolymphatic Prechamber
	put set description
FestCastDevourKilling:
	if ($monstercount < 1) then {
		gosub WaitMonstercount 1
		gosub Face next
	}
	if ($health < 100) then gosub Target SV 25
	else gosub Target ACS 25
	gosub WaitSpelltime 2.5
	gosub Cast
	if ("$SpellTimer.Devour.active" == "0") then {
		if matchre("$roomobjs", "(\S+) which appears dead") then {
			var FestCastDevour.consumeMob $1
			gosub Perform consume on %FestCastDevour.consumeMob
			if (%Perform.success == 1) then {
				gosub Prepare Devour 50
				gosub Harness 50
				gosub WaitSpelltime 18
				gosub Cast
			}
		}
	}
	if matchre("$roomobjs", "appears dead") then {
		gosub Loot
		#waiteval !matchre("$roomobjs", "appears dead") <- can't do this b/c mobs kill each other, could be more than 1 dead.
	}
	if ($health < 90) then goto FestCastDevourKilling
	if ("$SpellTimer.Devour.active" == "0") then goto FestCastDevourKilling
	return