#REQUIRE Cast.cmd
#REQUIRE Face.cmd
#REQUIRE Harness.cmd
#REQUIRE Loot.cmd
#REQUIRE Navigate.cmd
#REQUIRE Perform.cmd
#REQUIRE Prepare.cmd
#REQUIRE Send.cmd
#REQUIRE Target.cmd
#REQUIRE WaitMonstercount.cmd
#REQUIRE WaitSpelltime.cmd

gosub FestCastDevour
exit

FestCastDevour:
	gosub Navigate 210 rats
	gosub WaitMonstercount 1
	gosub Face next
FestCastDevourKilling:
	if ($health < 100) then gosub Target SV 25
	else gosub Target ACS 25
	gosub WaitSpelltime 2.5
	gosub Cast
	if ("$SpellTimer.Devour.active" == "0") then {
		if matchre("$roomobjs", "(\S+) which appears dead") then {
			var FestCastDevour.consumeMob $1
			# Todo: create perform verb/script, add this in:
			gosub Prepare Devour 50
			gosub Send RT "perform consume on %FestCastDevour.consumeMob" "^\[?\(?Roundtime:" "^This ritual may only be performed on a corpse\.$"
			gosub Harness 50
			gosub WaitSpelltime 18
			gosub Cast
		}
	}
	if matchre("$roomobjs", "appears dead") then {
		gosub Loot
		waiteval !matchre("$roomobjs", "appears dead")
	}
	if ($health < 90) then goto FestCastDevourKilling
	if ("$SpellTimer.Devour.active" == "0") then goto FestCastDevourKilling
	return