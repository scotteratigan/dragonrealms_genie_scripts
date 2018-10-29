gosub WaitStun
exit

WaitStun:
	#put echo Waiting on stun...
	if (!$stunned) then return
	pause .1
	goto WaitStun