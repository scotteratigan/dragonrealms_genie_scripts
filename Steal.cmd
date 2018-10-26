#REQUIRE Send.cmd
#REQUIRE Warning.cmd

gosub Steal %0
exit

Steal:
	var Steal.target $0
	action var Steal.wearingArmor 1 when ^Your armor is hindering your abilities\.$
	var Steal.wearingArmor 0
Stealing:
	gosub Send RT "steal %Steal.target" "^Moving nonchalantly, you manage to grab" "^Better finish your fight first\.$|^You haven't picked something to steal\!$|^You need at least one hand free to steal\.$|^You can't steal that\.$" "WARNING MESSAGES"
	if (%Steal.wearingArmor == 1) then gosub Warning Stole while wearing armor!
	# todo: consider running armor removal script here. Or perhaps checking for armor BEFORE stealing, lol. (But you wouldn't want to check each time.)
	action remove ^Your armor is hindering your abilities\.$
	return

# Todo: add learning amounts as Steal.learnAmount or something
#     action var noLearn ON; put #echo >Log OrangeRed *** Not learning from %item in %SHOP @ $Thievery.Ranks ranks when You don't feel you learned anything useful
#     action instant echo *** LEGENDARY GRAB!! when ^You learned exceptionally well from this nearly impossible theft\.$
#     action instant echo *** EPIC grab! when ^You learned very well from this
#     action instant echo *** AWESOME grab! when ^You learned rather well from this
#     action instant echo *** Great grab! when ^You learned acceptably from this