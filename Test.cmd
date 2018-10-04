#REQUIRE Advance.cmd
#REQUIRE SendAttack.cmd
#REQUIRE Send.cmd

Loop:
gosub WaitOnMob
gosub AdvanceMelee
gosub Draw
gosub Slice
gosub Chop
goto Loop


WaitOnMob:
	if ($monstercount > 0) then return
	put power
	wait
	goto WaitOnMob