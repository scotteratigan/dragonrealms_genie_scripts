#REQUIRE Peer.cmd
#REQUIRE Move.cmd

gosub AutoMistwoodCliff
exit

AutoMistwoodCliff:
	action var AutoMistwoodCliff.direction $1 when ^Peering closely at a faint path, you realize you would need to head (\w+)\.
	gosub Peer path
	gosub Move down
	gosub Move %AutoMistwoodCliff.direction
	if ($northwest == 1) then gosub Move northwest
	return