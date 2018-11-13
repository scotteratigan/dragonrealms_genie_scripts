#REQUIRE Send.cmd

#debuglevel 10
gosub Read %0
exit

Read:
	var Read.target $0
	var Read.success 0
	# Read.text contains the entire output, as an array.
	var Read.text
	var Read.matchres ^\s*-=\s+(Chapter|Table).+$|^You take a few moments to glance through.+catalog.*$|^You open .+ up to page.*$|^You flip open your .+ book and see\.\.\..*$|^The .+ contains a complete description of the .+ spell\.$|^Written in delicately formed letters on the first page of the catalog.*$|^.* reads:\s*$|^The .+ contains a complete description of the .+ spell.*$|^You open your logbook and sort through its contents\.$
	action (getReadText) action (getReadText) off when ^XML-<prompt time
	action (getReadText) var Read.text %Read.text|$1 when ^(.+)$
	action (getReadText) off
	action action (getReadText) on when (%Read.matchres)
Reading:
	gosub Send Q "read %Read.target" "%Read.matchres" "^There is nothing there to read\.$|^You should be holding .+ first\.$" "WARNING MESSAGES"
	pause .01
	action remove ^XML-<prompt time
	action remove ^(.*\S+.*)
	action remove (%Read.matchres)
	# Action if !matchre was not working reliably, so we're saving everything and stripping out what we don't want.
	# First, remove everything from the first prompt > or s> to the end of the string:
	eval Read.text replacere("%Read.text", "\|\w*>\|.*", "")
	# Remove XMLECHO lines:
	eval Read.text replace("%Read.text", "XML-<output class=mono/>-XML", "")
	eval Read.text replace("%Read.text", "XML-<output class=/>-XML", "")
	#eval Read.text replacere("%Read.text", "XML-<prompt time=\d+>&gt", "")
	# Remove any empty lines "||":
	eval Read.text replacere("%Read.text", "\|\s*\|", "|")
	# Remove any beginning spaces "  |" for instance:
	eval Read.text replacere("%Read.text", "\|\s+", "|")
	# Remove an extra spaces:
	eval Read.text replacere("%Read.text", "\s\s+", " ")
	# Remove | at start and end of string:
	eval Read.text replacere("%Read.text", "^\||\|$", "")
	
	#eval Read.text replacere("%Read.text", "\|XML(?!\|).*", "|") <- takes out innocent text... negative lookahead doesn't work here.
	echo Text is: %Read.text
	#waitforre \>\s*$
	if ("%Send.success" == "0") then return
	var Read.success 1
	return

# This text was not matching:
# You open your logbook and sort through its contents.
# This logbook is tracking a work order that has expired.  You must untie any items bundled with the logbook then ASK the trainer for another work order.
# <prompt time="1541534663">&gt;</prompt>
# I think the word This is problematic in a matchre? Otherwise I have no idea why this was failing.