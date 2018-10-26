#REQUIRE Send.cmd

gosub Read %0
exit

Read:
	var Read.target $0
	var Read.success 0
	# Read.text contains the entire output - cool!
	var Read.text
	var Read.matchres ^(You take a few moments to glance through the catalog\..*)$|^(You open .+ up to page.*)$|^(You flip open your .+ book and see\.\.\.)
	action (getReadText) if (!matchre("$1", "^XML|^Info|\>\s*$")) then var Read.text %Read.text|$1 when ^(.+)$
	action (getReadText) off
	action action (getReadText) on;var Read.text $1 when %Read.matchres
	action action (getReadText) off when ^.*>$
Reading:
	gosub Send Q "read %Read.target" "%Read.matchres" "FAIL MESSAGES" "WARNING MESSAGES"
	# Todo: figure out something better than pausing.
	waitforre \>\s*$
	pause .1
	if ("%Send.success" == "0") then return
	var Read.success 1
	#eval Read.text replacere("%Read.text", "^\|", "")
	echo Read.text: %Read.text
	return