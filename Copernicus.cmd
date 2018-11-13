#REQUIRE CraftMakeUnfinishedRasps.cmd
#REQUIRE CraftRepairFangCove.cmd

put /compile CraftMakeUnfinishedRasps.cmd
pause .3
put /compile CraftGiveRasps.cmd
pause .3
put /compile CraftRepairFangCove.cmd
pause 2

put .CraftGiveRasps
pause .1
CopernicusLoop:
	gosub CraftMakeUnfinishedRasps 20
	gosub CraftRepairFangCove
	goto CopernicusLoop