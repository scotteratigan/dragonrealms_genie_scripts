#REQUIRE Send.cmd

# Note: max items in bundle is 200. Message when full is the Where did you intend... message
# You flip through the lumpy bundle and find 200 skins in it.

gosub Bundle %0
exit

Bundle:
	var Bundle.option $0
Bundling:
	gosub Send Q "bundle %Bundle.option" "^You bundle up .+$|^You carefully fit .+$|^You notate the (.+) in the logbook then bundle it up for delivery\.$" "^That's not going to work\.  Type BUNDLE HELP for details\.$|^Where did you intend to put that\?  You don't have any bundles or they're all full or too tightly packed\!  Type BUNDLE HELP for more details\.$|^You need to be holding the (.+) to do that\.$|^You have already bundled enough items with the logbook to complete this work order\.  Please give it to a crafter trainer to complete it\.$|^The work order requires items of a higher quality, so you decide against bundling that\.$" ""
	# todo: try to create new bundle if none exist (That's not going to work)
	return