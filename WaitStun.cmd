gosub WaitStun
exit

WaitStun:
	#put echo Waiting on stun...
	pause .1
	if ($stunned) then goto WaitStun
	return