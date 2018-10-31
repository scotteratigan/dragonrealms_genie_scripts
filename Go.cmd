#REQUIRE Move.cmd

gosub Go %0
exit

Go:
	var Go.portal $0
Going:
	# todo: add in checks for dragging items or sneaking.
	gosub Move go %Go.portal
	return