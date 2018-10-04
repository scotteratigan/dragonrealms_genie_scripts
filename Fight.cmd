#REQUIRE AttackUntilKill.cmd
#REQUIRE Arrange.cmd
#REQUIRE Skin.cmd
#REQUIRE Loot.cmd
#REQUIRE GrabLoot.cmd

gosub Fight
exit

Fight:
	gosub AttackUntilKill
	gosub Arrange
	gosub Skin
	gosub Loot
	gosub GrabLoot
	return