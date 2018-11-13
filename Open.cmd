#REQUIRE Arrayify.cmd
#REQUIRE Send.cmd
#REQUIRE Unlock.cmd
# todo: do you need hands to open an item? test and get string.
gosub Open %0
exit

Open:
	var Open.target $0
	var Open.success 0
	var Open.boxContents null
	var Open.boxContentsArray null
	# Todo: replace this with just the box adjectives/nouns?:
	action var Open.boxContents $1 when ^In the .+ you see (.+)\.$
Opening:
	gosub Send Q "open %Open.target" "^You open.*$|^The .+ opens\.$|^With a practiced flick of your wrist, you snap open your .+\.$" "^It is locked\.$|^You rattle the handle to the .+\.  It's locked\.$|^You rattle the handle on .+  It appears to be locked\.$" "^That is already open\.$|^But it's already opened up as far as it will go\!$"
	var Open.response %Send.response
	# Pause below allows script to grab box contents in that special case:
	if (%Send.success == 1) then var Open.success 1
	pause .01
	action remove ^In the .+ you see (.+)\.$
	if ("%Open.boxContents" != "null") then {
		gosub Arrayify %Open.boxContents
		var Open.boxContentsArray %Arrayify.string
		echo Box contents: %Open.boxContentsArray
	}
	if (%Open.success == 1) then return
	if (matchre("%Open.response", "^It is locked\.$|^You rattle the handle to the .+\.  It's locked\.$||^You rattle the handle on .+  It appears to be locked\.$")) then {
		gosub Unlock %Open.target
		if (%Unlock.success == 1) then goto Opening
	}	
	return