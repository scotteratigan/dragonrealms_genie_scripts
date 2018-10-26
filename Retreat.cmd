#REQUIRE Send.cmd
gosub RetreatCompletely
exit

Retreat:
	# Sends single retreat command. See also RetreatCompletely and RetreatQuickly
	# Note: although this rarely generates RT, a failed attempt can. Additionally, you need to be standing to retreat, which the RT option includes.
	gosub Send RT "retreat" "^You are already as far away as you can get\!|^You retreat back to pole range\.|^You retreat from combat\.$|^You sneak back out to pole range\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	return

RetreatCompletely:
	# continues to retreat until at missile. Useful for if failure is likely or engaged status is unknown.
	gosub Send RT "retreat" "^You are already as far away as you can get\!|^You retreat back to pole range\.|^You retreat from combat\.$|^You sneak back out to pole range\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	if (matchre("^You retreat from combat|^You sneak back out of combat|^You are already as far away as you can get", "%Send.response")) then return
	goto RetreatCompletely

RetreatQuickly:
	# Sends both retreat commands simultaneously. Note - retreating to pole range isn't included. A double retreat should never result in partial success of pole range. 
	gosub Send Q "retreat;retreat" "^You are already as far away as you can get\!|^You retreat from combat\.$|^You sneak back out of combat\.$" "^You try to back away from .+ but are unable to get away\!$"
	if (matchre("^You try to back away", "%Send.response")) then goto RetreatQuickly
	return