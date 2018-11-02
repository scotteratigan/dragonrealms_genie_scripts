gosub WaitMonstercount %0
exit

WaitMonstercount:
	var WaitMonstercount.desiredMobs $1
	if (!matchre("%WaitMonstercount.desiredMobs", "^\s*\d+\s*$")) then var WaitMonstercount.desiredMobs 1
WaitingMonstercount:
	if ($monstercount >= %WaitMonstercount.desiredMobs) then return
	# todo: skill training here.
	put wait
	pause 2
	goto WaitingMonstercount