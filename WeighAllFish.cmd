#REQUIRE Drop.cmd
#REQUIRE Get.cmd
#REQUIRE Put.cmd
#REQUIRE Rummage.cmd

gosub WeighAllFish %0
exit

WeighAllFish:
	var WeighAllFish.container $0
	gosub Rummage /f %WeighAllFish.container
	var WeighAllFish.list %Rummage.nounList
	var WeighAllFish.index 0
	eval WeighAllFish.maxIndex count("%WeighAllFish.list", "|")
WeighingAllFish:
	eval WeighAllFish.currentFish element("%WeighAllFish.list", %WeighAllFish.index)
	gosub Get %WeighAllFish.currentFish from %WeighAllFish.container
	#gosub Put %WeighAllFish.currentFish on scale <- doesn't work because some fish are more 'generic' than others
	gosub Put #$righthandid on scale
	gosub Drop my %WeighAllFish.currentFish
	math WeighAllFish.index add 1
	if (%WeighAllFish.index <= %WeighAllFish.maxIndex) then goto WeighingAllFish
	return