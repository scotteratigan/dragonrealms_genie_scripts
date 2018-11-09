#REQUIRE Send.cmd
#REQUIRE Navigate.cmd
#REQUIRE HuntFor.cmd
#REQUIRE Move.cmd
#REQUIRE Error.cmd

# Assumes you are in the same zone as the trainer.
# Only works in FC for now.
# Usage: CraftFindFangCoveTrainer Forging Society Master Phahoe|Outfitting Society Master Varcenti|Alchemy Society Master Swetyne|Engineering Society Master Brogir

gosub CraftFindFangCoveTrainer %0
exit

CraftFindFangCoveTrainer:
	var CraftFindFangCoveTrainer.trainerName $0
	if (contains("%CraftFindFangCoveTrainer.trainerName", "Brogir")) then var CraftFindFangCoveTrainer.trainerName Engineering Society Master Brogir
	if (contains("%CraftFindFangCoveTrainer.trainerName", "Phahoe")) then var CraftFindFangCoveTrainer.trainerName Forging Society Master Phahoe
	if (contains("%CraftFindFangCoveTrainer.trainerName", "Swetyne")) then var CraftFindFangCoveTrainer.trainerName Alchemy Society Master Swetyne
	if (contains("%CraftFindFangCoveTrainer.trainerName", "Varcenti")) then var CraftFindFangCoveTrainer.trainerName Outfitting Society Master Varcenti
	var CraftFindFangCoveTrainer.success 0
CraftFindingFangCoveTrainer:
	if (contains("$roomobjs", "%CraftFindFangCoveTrainer.trainerName")) then {
		var CraftFindFangCoveTrainer.success 1
		return
	}
	gosub Navigate 150 233
	if ("%CraftFindFangCoveTrainer.trainerName" == "Engineering Society Master Brogir") then gosub Navigate 150 "Engineering Society"
	if ("%CraftFindFangCoveTrainer.trainerName" == "Forging Society Master Phahoe") then gosub Navigate 150 "Forging Society"
	if ("%CraftFindFangCoveTrainer.trainerName" == "Alchemy Society Master Swetyne") then gosub Navigate 150 "Alchemy Society"
	if ("%CraftFindFangCoveTrainer.trainerName" == "Outfitting Society Master Varcenti") then gosub Navigate 150 "Outfitting Society"
	gosub HuntFor %CraftFindFangCoveTrainer.trainerName
	if (%HuntFor.success == 1) then goto CraftFindingFangCoveTrainer
	# Ok, hunting didn't work, let's search the entire zone room by room.
	gosub Navigate 150 233
	# Searches each room, returns when we've found the trainer
	gosub SearchFor east|east|east|southeast|southeast|east|east|northeast|east|west|southwest|west|west|northwest|northwest|west|west|west|northeast|northeast|northeast|north|north|northeast|southwest|south|south|southwest|southwest|southwest|north|north|north|north|north|north|northeast|southwest|south|south|south|south|south|south|west|northwest|southwest|west|west|east|east|northeast|southeast|east
	goto CraftFindingFangCoveTrainer

SearchFor:
	var movementArray $1
	var index 0
	eval maxIndex count("%movementArray", "|")
SearchingFor:
	eval currentMovement element("%movementArray", %index)
	gosub Move %currentMovement
	if (contains("$roomobjs", "%CraftFindFangCoveTrainer.trainerName")) then return
	math index add 1
	if (%index < %maxIndex) then goto SearchingFor
	gosub Error Searched every room of FC but failed to find trainer %CraftFindFangCoveTrainer.trainerName! Searching again.
	var index 0
	goto SearchingFor





