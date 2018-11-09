#REQUIRE ClearHand.cmd
#REQUIRE Send.cmd
#REQUIRE Untie.cmd

gosub Ask %0
exit

Ask:
	var Ask.command $0
	var Ask.success 0
	var Ask.chapter 0
	var Ask.trainer null
	var Ask.itemRequested null
	var Ask.quantityRequested 0
	var Ask.qualityRequested null
	# qualityRequested can be: finely-crafted, of superior quality, of exceptional quality
	var Ask.timeRemaining 0
	action var Ask.chapter $1 when ^You seem to recall this item being somewhere in chapter (\d+) of the instruction book\.$
	action var Ask.trainer $1;var Ask.itemRequested $2;var Ask.quantityRequested $3;var Ask.timeRemaining $4 when ^(\w+) shuffles through some notes and says, .Alright, this is an order for (.+)\. I need (\d+) (.+), made from any material and due in (\d+) roisaen\.  Please complete the items, bundle them with your logbook and then give me the logbook to complete this order\.  Good luck\!.$
Asking:
	gosub Send Q "ask %Ask.command" "^.+ hands you a .* gem pouch.$|^.+ hands you a rope\.$|^You seem to recall this item being somewhere in chapter \d+ of the instruction book\.$|^\[ASK POLTU FOR TASK again if you agree to his terms\.\]$|^\[You may accept by typing ACCEPT TASK, or decline by typing DECLINE TASK\]$" "^To whom are you speaking\?$|^Usage: ASK <player>  ABOUT/FOR <subject>.*$|^Free one of your hands first\.$|^.+ says, .That is, I could if you had an empty hand.*$|^\w+ stares blankly at you and says, .Come again\?.$|^\w+ shakes (his|her) head and says, .I only deal with .+ here..$|^\w+ says, .That's all well and good, but I need to see your logbook so I can give you a work order\..$|^You realize you have items bundled with the logbook, and should untie them before getting a new work order\.$|^Dealer Poltu looks at you and says, .You are already on a task\.  Please complete that task, or you may ask to cancel the job by asking me FOR TASK CANCEL\..$" "WARNING MESSAGES"
	action remove ^You seem to recall this item being somewhere in chapter (\d+) of the instruction book\.$
	action remove ^(\w+) shuffles through some notes and says, .Alright, this is an order for (.+)\. I need (\d+) (.+), made from any material and due in (\d+) roisaen\.  Please complete the items, bundle them with your logbook and then give me the logbook to complete this order\.  Good luck\!.$
	var Ask.response %Send.response
	if (%Send.success == 1) then {
		var Ask.success 1
		echo Ask.chapter: %Ask.chapter
		echo Ask.trainer: %Ask.trainer
		echo Ask.itemRequested: %Ask.itemRequested
		echo Ask.quantityRequested: %Ask.quantityRequested
		echo Ask.timeRemaining: %Ask.timeRemaining
	}
	if ("%Ask.response" == "[ASK POLTU FOR TASK again if you agree to his terms.]") then goto Asking
	if ("%Ask.response" == "You realize you have items bundled with the logbook, and should untie them before getting a new work order.") then {
		if ("$lefthand" == "Empty") then {
			gosub Untie my logbook
			if (%Untie.success == 1) then {
				gosub ClearHand left
				if (%ClearHand.success == 1) then goto Asking
			}
		}
	}
	return