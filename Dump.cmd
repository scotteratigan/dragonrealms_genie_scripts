#REQUIRE Send.cmd

#You'll need to stand up first.
# Should that just go into send?

gosub Dump %0
exit

Dump:
	var Dump.command $0
	var Dump.success 0
Dumping:
	gosub Send Q "template %Dump.command" "^\[You have marked this room to be cleaned by the janitor\.  It should arrive shortly\.\]$" "^Dump what\?  You must be holding the container you wish to dump\.$" "^\The janitor was recently summoned to this room\.  Please wait \d+ seconds\.$"
	if ("%Send.success" == "1") then var Dump.success 1
	return

#> rem bag

#You take off a dark watersilk bag bearing a detailed cambrinth medallion.
#> dump shaving into bucket
#You dump a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, a replenished khor'vela shaving, and several other items into a bucket of pumpkin-colored viscous gloop.