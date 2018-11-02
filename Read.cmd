#REQUIRE Send.cmd

gosub Read %0
exit

Read:
	#debuglevel 10
	var Read.target $0
	var Read.success 0
	# Read.text contains the entire output - cool!
	var Read.text
	var Read.matchres ^You take a few moments to glance through the catalog.*$|^You open .+ up to page.*$|^You flip open your .+ book and see\.\.\..*$|^The .+ contains a complete description of the .+ spell\.$|^Written in delicately formed letters on the first page of the catalog.*$|^.* reads:\s*$
	action (getReadText) if (!matchre("$1", "^XML|^Info|\>\s*$")) then var Read.text %Read.text|$1 when ^(.+)$
	action (getReadText) action (getReadText) off;echo Read.text: %Read.text when ^.*>.*$
	action (getReadText) off
	action action (getReadText) on when (%Read.matchres)
	#;var Read.text $1
Reading:
	gosub Send Q "read %Read.target" "%Read.matchres" "FAIL MESSAGES" "WARNING MESSAGES"
	pause .1
	#waitforre \>\s*$
	if ("%Send.success" == "0") then return
	var Read.success 1
	return