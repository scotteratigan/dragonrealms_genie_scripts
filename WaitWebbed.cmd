gosub WaitWebbed
exit

WaitWebbed:
	#put echo Waiting to escape the webs...
	if (!$webbed) then return
	pause .1
	goto WaitWebbed