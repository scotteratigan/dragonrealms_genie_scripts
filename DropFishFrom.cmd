#REQUIRE Drop.cmd
#REQUIRE Get.cmd
#REQUIRE Put.cmd
#REQUIRE Rummage.cmd

# Drops all fish that you're carrying in specified container.

gosub DropAllFish %0
exit

DropAllFish:
	var DropAllFish.container $0
	gosub Rummage /f %DropAllFish.container
	var DropAllFish.list %Rummage.nounList
	var DropAllFish.index 0
	eval DropAllFish.maxIndex count("%DropAllFish.list", "|")
DroppingAllFish:
	eval DropAllFish.currentFish element("%DropAllFish.list", %DropAllFish.index)
	gosub Get %DropAllFish.currentFish from %DropAllFish.container
	gosub Drop my %DropAllFish.currentFish
	math DropAllFish.index add 1
	if (%DropAllFish.index <= %DropAllFish.maxIndex) then goto DroppingAllFish
	return