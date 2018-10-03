#REQUIRE Advance.cmd
#REQUIRE SendAttack.cmd
#REQUIRE Send.cmd

Loop:
gosub WaitOnMob
gosub ADVANCE_TO_MELEE
gosub DRAW
gosub SLICE
gosub CHOP
goto Loop


WaitOnMob:
	if ($monstercount > 0) then return
	put power
	wait
	goto WaitOnMob