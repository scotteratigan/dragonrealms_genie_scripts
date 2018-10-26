#REQUIRE Send.cmd
# todo: do you need hands to open an item? test and get string.
gosub Open %0
exit

Open:
	var Open.target $0
Opening:
	gosub Send Q "open %Open.target" "^You open|^That is already open\.$" "^It is locked\.$"
	return