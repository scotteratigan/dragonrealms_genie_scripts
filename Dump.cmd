#REQUIRE Send.cmd

#You'll need to stand up first. - Moved to Send.cmd, but do other verbs share this exact text?

gosub Dump %0
exit

Dump:
	var Dump.command $0
	var Dump.success 0
	var Dump.items null
	var Dump.trashContainer null
	# Conisder adding Dump.originContainer
	# Trick is, it could be in either hand, so you'd need to parse the Dump.command itself.
	action var Dump.items $1;var Dump.trashContainer $2 when ^You dump (.+) into (.+)\.$
Dumping:
	gosub Send Q "dump %Dump.command" "^\[You have marked this room to be cleaned by the janitor\.  It should arrive shortly\.\]$|^You dump .+ into .+$" "^Dump what\?  You must be holding the container you wish to dump\.$" "^The janitor was recently summoned to this room\.  Please wait \d+ seconds\.$"
	action remove ^You dump (.+) into (.+)\.$
	if ("%Send.success" == "1") then var Dump.success 1
	return

#> dump shaving into bucket
#You dump a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, and several other items into a bucket of pumpkin-colored viscous gloop.