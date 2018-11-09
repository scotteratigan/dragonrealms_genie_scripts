#REQUIRE ClearHand.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Nounify.cmd
#REQUIRE Open.cmd
#REQUIRE Read.cmd
#REQUIRE Send.cmd
#REQUIRE Turn.cmd

gosub Push %0
exit

Push:
	var Push.command $0
	var Push.success 0
	if (contains("%Push.command", "fuel with")) then {
		if (!contains("$lefthandnoun $righthandnoun", "shovel")) then {
			if (!contains("$lefthand $righthand", "Empty")) then {
				gosub ClearHand left
			}
			gosub Get my shovel
			if (%Get.success != 1) then {
				gosub Error Failed to get shovel to push fuel, aborting.
				return
			}
		}
	}
	if (contains("%Push.command", "bellows")) then {
		if (!contains("$lefthandnoun $righthandnoun", "bellows")) then {
			if (!contains("$lefthand $righthand", "Empty")) then {
				gosub ClearHand left
			}
			gosub Get my bellows
			if (%Get.success != 1) then {
				gosub Error Failed to get bellows to fan fire, aborting.
				return
			}
		}
	}
Pushing:
	#action var Push.turnGrindstone 1 when ^The grinding wheel is not spinning fast enough to do that and needs to be turned some more\.$|^The grinding wheel needs to be spinning before it can be used to polish and sharpen weapons\.  Perhaps you should try turning it\?$
	#var Push.turnGrindstone 0
	gosub Send Q "push %Push.command" "^You push .+ to the side and tear off a claim notice from your packet\.  After affixing the form securely to .+, you record it on a deed for your records\.$|^You quickly find a rhythm with shoveling load after load of coal into the fire\.  Eventually the fuel begins to catch and the fire picks up in intensity\.$|^Sweat dripping from your face, you heap pile after pile of coal atop the fire with your shovel\.  Satisfied, you lean on the shovel and wipe off your brow\.$|^Gripping the shovel tightly, you slam it deep into the pile of fuel and give it a hard kick\.   Straining, you remove the shovel with a mound of coal atop it and toss the coal onto the fire\.$|^With wide sweeps of the shovel you scatter fuel evenly across the fire\.  Then, for good measure you shovel out the spent ash into the nearby waste bucket\.$|^Gusts of hot steam billow from the tub as you submerse the scorching hot .+\.$|^Wisps of hot smoke curl up from the tub as you slip the .+ into it\.$|^Using short pumps of the bellows you fan the flames of the fire\.$|^You pump your bellows fiercely over the hot coals\.$|^You force copious amounts of air into the hot coals by pumping the bellows\.$|^You stoke the fire with strong pumps of your bellows\.$|^An explosive blast of steam erupts from your .+ as it hits the cool water of the slack tub\!$|^With grinding complete, the metal now needs protection by pouring oil on it\.$|^Flipping through the .+, you find room in a matching section, and copy in the spell\.  Your .+ crumbles to dust afterward\.$|^Not finding a matching section, you flip to an empty section, and after labeling it, you copy in the spell\.  Your .+ crumbles to dust afterward\.$" "^Push what\?$|^That tool does not seem suitable for that task\.$|^You need another .+ to continue crafting.*$|^The grinding wheel is not spinning fast enough to do that and needs to be turned some more\.$|^The grinding wheel needs to be spinning before it can be used to polish and sharpen weapons\.  Perhaps you should try turning it\?$|^Flipping through your .+, you realize there's no more room\.$|^\[If you're trying to add something to your .+, you need to open the .+ first\.\]$|^Realizing that the \w+ is not labelled, you stop, unsure of where to add the spell in\.$" "WARNING MESSAGES"
	#action remove ^The grinding wheel is not spinning fast enough to do that and needs to be turned some more\.$|^The grinding wheel needs to be spinning before it can be used to polish and sharpen weapons\.  Perhaps you should try turning it?$
	var Push.response %Send.response
	if ("%Send.success" == "1") then {
		var Push.success 1
		return
	}
	if (matchre("%Push.response", "^\[If you're trying to add something to your .+, you need to open the (.+) first\.\]$")) then {
		var Push.containerToOpen $1
		gosub Nounify %Push.containerToOpen
		var Push.containerToOpen %Nounify.noun
		gosub Open %Push.containerToOpen
		if (%Open.success == 1) then goto Pushing
	}
	if (matchre("%Push.response", "^Realizing that the \w+ is not labelled, you stop, unsure of where to add the spell in\.$")) then {
		# Assumes scroll is in right hand:
		gosub Read #$righthandid
		if (%Read.success == 1) then goto Pushing
	}
	#if (%Push.turnGrindstone == 1) then {
	if (matchre("%Push.response", "^The grinding wheel is not spinning fast enough to do that and needs to be turned some more\.$|^The grinding wheel needs to be spinning before it can be used to polish and sharpen weapons\.  Perhaps you should try turning it\?$")) then {
		gosub Turn grindstone
		if (%Turn.success == 1) then goto Pushing
	}
	return