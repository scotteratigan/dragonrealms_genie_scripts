#REQUIRE Numerify.cmd
#REQUIRE Send.cmd
#REQUIRE Inventory.cmd
#REQUIRE Open.cmd

# There are two different modes for this script.
# Default mode, count <container> sends the command to the game, gets a text number (one hundred seventy-two), and converts that into a number.
# Alternate mode, count <item> in <container> will inventory the container, and count the occurrances of the text you specify.

gosub Count %0
exit

Count:
	var Count.command $0
	var Count.success 0
	var Count.textQuantity null
	var Count.container null
	var Count.quantity -1
	# Check for alternate mode:
	if (matchre("%Count.command", "(.+) in (.+)")) then {
		var Count.object $1
		var Count.container $2
		gosub Inventory %Count.container
		var Count.text %Inventory.text
		eval Count.quantity count("%Count.text", "%Count.object")
		echo There are %Count.quantity %Count.object in %Count.container
		return
	}
Counting:
	action var Count.textQuantity $1;var Count.container $2 when ^There are (.+) non-ammunition items inside your (.+)\.$
	gosub Send RT "count %Count.command" "^You count up the items in your.+\.\.\.$" "^That doesn't tell you much of anything\.$|^You'll really need to be holding or wearing the .+ to count anything in it\.$|^That's going to be hard to do until you actually open .+\.$" "WARNING MESSAGES"
	var Count.response %Send.response
	pause .01
	action remove ^There are (.+) non-ammunition items inside your (.+)\.$
	if ("%Count.textQuantity" != "null") then {
		gosub Numerify %Count.textQuantity
		var Count.quantity %Numerify.value
		echo Count of %Count.command is %Count.quantity
	}
	if ("%Send.success" == "1") then {
		var Count.success 1
		return
	}
	if (matchre("%Count.response", "^That's going to be hard to do until you actually open .+\.$")) then {
		gosub Open %Count.command
		if (%Open.success == 1) then goto Counting
	}

	return

#You count up the items in your void-black rift...
#There are one hundred seventy-two non-ammunition items inside your void-black rift.\
#Roundtime: 2 seconds.