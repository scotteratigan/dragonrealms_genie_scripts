#REQUIRE Get.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Stand.cmd
#REQUIRE Navigate.cmd

if ("$charactername" != "Mousey") then  {
	echo This script is for your noob only!
	exit
}
gosub Navigate 210 snake

FestSnakePit:
	gosub Get treasure
	pause 10
	if ($dead == 1) then goto FestSnakePitDied
	gosub ClearHand both
	goto FestSnakePit

FestSnakePitDied:
	pause 15
	put depart
	wait
	gosub Stand
	gosub Navigate 210 77
	gosub Navigate 210 snake
	goto FestSnakePit