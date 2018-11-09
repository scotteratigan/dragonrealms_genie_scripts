#REQUIRE Send.cmd

gosub Order %0
exit

Order:
	var Order.command $0
	var Order.success 0
	var Order.itemToPurchase null
	var Order.amount 0
	var Order.currency null
Ordering:
	var Order.repeatCommand 0
	action var Order.repeatCommand 1;var order.itemToPurchase $1;var order.amount $2;var order.currency $3 when ^The attendant says, .You can purchase (.+) for (\d+) (\w+)\.  Just order it again and we'll see it done\!.$
	gosub Send Q "order %Order.command" "^$|^The attendant says, .You can purchase .+ for \d+ \w+\.  Just order it again and we'll see it done\!.$|^The attendant takes some coins from you and hands you .+\.$|^You see the following items for sale .*:$" "^Order what\?$|^An attendant walks over and asks, .Which item number did you wish to order\?.$|^The attendant replies, .I am sorry, but we only have \d+ items for sale here\.  Did you mean another\?.|^The attendant shrugs and says, .Ugh, you don't have enough coins to purchase .+\!." "WARNING MESSAGES"
	action remove ^The attendant says, .You can purchase (.+) for (\d+) (\w+)\.  Just order it again and we'll see it done\!.$
	if (%Order.repeatCommand == 1) then goto Ordering
	var Order.response %Send.response
	if ("%Send.success" == "1") then {
		var Order.success 1
		return
	}
	return

# Todo: special mode to capture all items for sale, similar to read script:
# 1).  a diagonal-peen hammer.................. 451 Dokoras
# A fundamental tool used to pound metal on an anvil.
# 2).  some straight iron tongs................ 451 Dokoras
# These sturdy tongs help grip metal being pounded on with a smith's hammer.
# 3).  a curved iron shovel.................... 451 Dokoras
# Basic tool for shoveling fuel into the forges, and mining.
# 4).  some plain iron pliers.................. 451 Dokoras
# Pliers are useful for bending wire and weaving armor links into place.
# 5).  a leather bellows....................... 1082 Dokoras
# A handy tool for stoking forge fires.
# 6).  a flask of oil.......................... 721 Dokoras
# A thick and syrupy substance that easily coats and lubricates metal.
# 7).  a stirring rod.......................... 451 Dokoras
# A stone rod used to stir crucibles full of molten metal.
# 8).  a pouch of aerated salts................ 90 Dokoras
# Useful for cleaning and repairing crucibles.
# 9).  a flask of flux......................... 225 Dokoras
# A flask of borax flux useful for refining metals in a crucible.
# 10).  an iron wire brush..................... 360 Dokoras
# A thick brush used to clean and repair metal tools.
# 11).  a cleaning cloth....................... 360 Dokoras
# Used to clean and bring out new appearances of crafted items.
# [You may purchase items from the shopkeeper with ORDER #]