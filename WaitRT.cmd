# Not currently used.
gosub WaitRT
exit

WaitRT:
	put echo Waiting on rt...
	pause .1
	if ($roundtime > 0) then goto WaitRT
	return