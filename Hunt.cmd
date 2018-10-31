#REQUIRE Send.cmd

# Ok, the advanced functionality is working, but since all variables are local you can't really use it from the command line... I'll have to think about which direction I want to go here (no pun intended)

gosub Hunt %0
exit

Hunt:
	var Hunt.option $0
	var Hunt.success 0
	var Hunt.highestNumber 0
	var Hunt.lastSearchTime 
Hunting:
	#debuglevel 10
	action var Hunt.lastPath $1;echo %Hunt.lastPath when ^To the (.+):
	action var Hunt.highestNumber $1;var Hunt.lastPrey $2;echo Hunt.lastPrey %Hunt.lastPrey;var Hunt.pathArray %Hunt.pathArray|%Hunt.lastPath;echo Hunt.pathArray: %Hunt.pathArray when ^\s\s(\d+)\)   (.+)$
	action var Hunt.lastSearchTime $gametime;echo Hunt.lastSearchTime %Hunt.lastSearchTime;var Hunt.pathArray none;var Hunt.stepsTaken null when ^You take note of all the tracks in the area, so that you can hunt anything nearby down\.$
	action var Hunt.originRoom $roomid;echo Hunted from Hunt.originRoom %Hunt.originRoom;var Hunt.lastTrackTime $gametime;echo Hunt.lastTrackTime %Hunt.lastTrackTime;eval Hunt.stepsTaken element("%Hunt.pathArray", %Hunt.option);echo Steps taken: %Hunt.stepsTaken when ^You move to hunt down your prey\.$
	gosub Send RT "hunt %Hunt.option" "^You take note of all the tracks in the area, so that you can hunt anything nearby down\.$|^You move to hunt down your prey\.$" "^You don't have that target currently available\.$|^You'll need to be in the area you found the tracks in order to hunt along them\.$" "WARNING MESSAGES"
	pause .05
	if ("%Send.success" == "1") then var Hunt.success 1
	echo Hunt.highestNumber %Hunt.highestNumber

	return

#>hunt
#You take note of all the tracks in the area, so that you can hunt anything nearby down.
#You were unable to locate any followable tracks.
#Roundtime: 8 sec.

#hunt
#You take note of all the tracks in the area, so that you can hunt anything nearby down.
#To the out, northwest:
#  1)   a Halfling priest of Glythtide
#  2)   a colorfully garbed maze spieler
#Roundtime: 8 sec.

#> hunt
#You take note of all the tracks in the area, so that you can hunt anything nearby down.
#To the west:
#  1)   an Estate Holder representative
#To the west, west, west:
#  2)   a cheerful Elven peddler
#To the west, north, east, east:
#  3)   the Bacon Man
#Roundtime: 8 sec.

#> hunt 1
#You don't have that target currently available.

#> hunt 2
#You move to hunt down your prey.
#[The Strand, Sandy Path]
#You can hear the Oxenwaithe lapping gently at its bank, creating a soothing sound not unlike a lullaby.  The light reflected from the moons provide shimmery paths along the sandy embankments at water's edge.
#You also see a path leading toward a caged blade spider, a Halfling priest of Glythtide, a great banyan tree split down the center by a large rock, a festive meeting portal and a colorfully garbed maze spieler.
#Obvious paths: southeast, northwest.
#Roundtime: 2 sec.