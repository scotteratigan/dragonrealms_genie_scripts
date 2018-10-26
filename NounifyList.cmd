#REQUIRE Error.cmd
#REQUIRE Nounify.cmd
gosub NounifyList %0
exit

NounifyList:
	var NounifyList.input $0
	var NounifyList.list
	eval NounifyList.maxIndex count("%NounifyList.input", "|")
	var NounifyList.index 0
	var NounifyList.success 0
	if ("%NounifyList.input" == "") then {
		gosub Error NounifyList called with no list of items to nounify.
		return
	}
NounifyingList:
	eval NounifyList.lastItem element("%NounifyList.input", %NounifyList.index)
	gosub Nounify %NounifyList.lastItem
	var NounifyList.list %NounifyList.list|%Nounify.noun
	math NounifyList.index add 1
	if (%NounifyList.index <= %NounifyList.maxIndex) then goto NounifyingList
	eval NounifyList.list replacere("%NounifyList.list", "^\|", "")
	var NounifyingList.success 1
	put #tvar NounifyList.list %NounifyList.list
	return