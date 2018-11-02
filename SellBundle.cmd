#REQUIRE ClearHand.cmd
#REQUIRE Sell.cmd
#REQUIRE Remove.cmd
#REQUIRE Wear.cmd
#REQUIRE Look.cmd
#REQUIRE Get.cmd
#REQUIRE Nounify.cmd
#REQUIRE Bundle.cmd

gosub SellBundle %0
exit

SellBundle:
	# Todo: add success/failure checks along the way.
	#var SellBundle.success 0
	# Todo: add handling of tight bundles?
	# If you aren't holding a single bundle, clear the hands.
	if (!matchre("$righthand-$lefthand", "lumpy bundle-Empty|Empty-lumpy bundle")) then gosub ClearHand both
	if (!contains("$lefthand $righthand", "bundle")) then gosub Remove my lumpy bundle
	gosub Look in my lumpy bundle
	eval SellBundle.itemToSave element("%Look.contentsList", 0)
	gosub Nounify %SellBundle.itemToSave
	var SellBundle.itemToSave %Nounify.noun
	gosub Get %SellBundle.itemToSave from my lumpy bundle
	gosub Sell my lumpy bundle
	gosub Bundle
	gosub Wear my bundle
	return