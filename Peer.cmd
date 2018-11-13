#REQUIRE Send.cmd

gosub Peer %0
exit

Peer:
	var Peer.command $0
	var Peer.success 0
Peering:
	gosub Send Q "peer %Peer.command" "^You peer.*|^Peering closely at.*$" "^\[Usage:  PEER .*$" "WARNING MESSAGES"
	var Peer.response %Send.response
	if ("%Send.success" == "1") then {
		var Peer.success 1
		return
	}
	return