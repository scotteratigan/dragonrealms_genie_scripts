#REQUIRE Send.cmd
gosub RETREAT_COMPLETELY
exit

RETREAT:
	# Sends single retreat command. See also RETREAT_COMPLETELY and RETREAT_QUICK
	# Note: although this rarely generates RT, a failed attempt can. Additionally, you need to be standing to retreat, which the RT option includes.
	gosub Send RT "retreat" "^You are already as far away as you can get\!|^You retreat back to pole range\.|^You retreat from combat\.$|^You sneak back out to pole range\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	return

RETREAT_COMPLETELY:
	# continues to retreat until at missile. Useful for if failure is likely or engaged status is unknown.
	gosub Send RT "retreat" "^You are already as far away as you can get\!|^You retreat back to pole range\.|^You retreat from combat\.$|^You sneak back out to pole range\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	if (matchre("^You retreat from combat|^You sneak back out of combat|^You are already as far away as you can get", "%SEND.response")) then return
	goto RETREAT_COMPLETELY

RETREAT_QUICK:
	# Sends both retreat commands simultaneously. Note - retreating to pole range isn't included. A double retreat should never result in partial success of pole range. 
	gosub Send Q "retreat;retreat" "^You are already as far away as you can get\!|^You retreat from combat\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	if (matchre("^You try to back away", "%SEND.response")) then goto RETREAT_QUICK
	return