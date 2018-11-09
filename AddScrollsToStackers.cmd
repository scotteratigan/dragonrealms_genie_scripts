#REQUIRE ClearHand.cmd
#REQUIRE AddScrollToStackers.cmd

gosub AddScrollsToStackers
exit

AddScrollsToStackers:
	var AddScrollsToStackers.scrollList clay tablet|faded vellum|glossy parchment|hhr'lav'geluhh bark|moldering scroll|ostracon|papyrus roll|seishaka leaf|smudged parchment|tattered scroll|wax tablet|yellowed scroll|scroll
	var AddScrollsToStackers.scrollContainer my rift
	gosub ClearHand both
	var AddScrollsToStackers.index 0
	eval AddScrollsToStackers.maxIndex count("%AddScrollsToStackers.scrollList", "|")
AddingScrollsToStackers:
	eval AddScrollsToStackers.currentScroll element("%AddScrollsToStackers.scrollList", %AddScrollsToStackers.maxIndex)
	gosub Get %AddScrollsToStackers.currentScroll from %AddScrollsToStackers.scrollContainer
	if (%Get.success == 1) then {
		gosub AddScrollToStackers
		goto AddingScrollsToStackers
	}
	math AddScrollsToStackers.index add 1
	if (%AddScrollsToStackers.index < %AddScrollsToStackers.maxIndex) then goto AddingScrollsToStackers
	return