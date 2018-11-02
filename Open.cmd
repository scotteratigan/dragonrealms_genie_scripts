#REQUIRE Send.cmd
# todo: do you need hands to open an item? test and get string.
gosub Open %0
exit

Open:
	var Open.target $0
	var Open.success 0
Opening:
	gosub Send Q "open %Open.target" "^You open.*$|^With a practiced flick of your wrist, you snap open your .+\.$" "^It is locked\.$" "^That is already open\.$"
	if ("%Send.success" == "1") then var Open.success 1
	return