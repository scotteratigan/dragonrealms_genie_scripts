#REQUIRE Get.cmd
#REQUIRE Error.cmd
#REQUIRE Put.cmd
#REQUIRE Push.cmd
gosub AddScrollToStackers
exit


AddScrollToStackers:
	var AddScrollToStackers.success 0
	# Assumes we're holding the scroll in one hand, and nothing in the other hand.
	if ("$lefthand" != "Empty") then {
		gosub Error AddScrollToStackers: No free hand to grab stackers, aborting!
		return
	}
	if ("$righthand" == "Empty") then {
		gosub Error AddScrollToStackers: Need to hold scroll in right hand, aborting!
		return
	}
	# Assumes there's at least 1 element in the stacker list:
	var AddScrollToStackers.stackerList portfolio|binder|black tome|wizard's tome|notebook|hard-covered book|hairy book|scroll booklet|simple folio|scroll folio|second scroll book|leaves|elegant folio
	var AddScrollToStackers.stackerContainer my duffel bag
	var AddScrollToStackers.unstackableScrollContainer my duffel bag
	eval AddScrollToStackers.maxStackerIndex count("%AddScrollToStackers.stackerList", "|")
	var AddScrollToStackers.stackerIndex 0
AddingScrollToStackers:
	eval AddScrollToStackers.currentStacker element("%AddScrollToStackers.stackerList", %AddScrollToStackers.stackerIndex)
	gosub Get %AddScrollToStackers.currentStacker from %AddScrollToStackers.stackerContainer
	if (%Get.success == 1) then {
		gosub Push #$lefthandid with #$righthandid
		if (%Push.success == 1) then {
			var AddScrollToStackers.success 1
			gosub Put #$lefthandid in %AddScrollToStackers.stackerContainer
			return
		}
	}
	gosub Put #$lefthandid in %AddScrollToStackers.stackerContainer
	math AddScrollToStackers.stackerIndex add 1
	if (%AddScrollToStackers.stackerIndex < %AddScrollToStackers.maxStackerIndex) then goto AddingScrollToStackers
	gosub Put #$righthandid in %AddScrollToStackers.unstackableScrollContainer
	return
