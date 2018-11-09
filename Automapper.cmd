#REQUIRE Climb.cmd
#REQUIRE Move.cmd
#REQUIRE MoveSetRoomId.cmd
#REQUIRE Echo.cmd
##REQUIRE Stand.cmd?

# Todo: set $destination? on /g command, auto-resume if $destination is not null

# Assumes global $moveSuccessStrings (set by running Init.cmd)
# Note: the standard gosub template would be difficult to implement here.
# We can't pass %0 into $0 because the quotes are stripped out, rendering a movement string that can't be deciphered.
# Example: "go path east north climb wall south"
var maxSendQueue 2
# Run slowly if we're searching for something:
if contains("|$scriptlist|", "|festsearchfor.cmd|") then var maxSendQueue 1
# Todo: allow a var to control this setting?
# Note: scriptlist is always lowercase.
var sendQueue 0
action goto AutomapperFailed when ^\.\.\.wait.*$|^I could not find what you were referring to\.$|^Sorry,.*$|^What were you referring to\?$|^You can't do that\.$|^You can't go there\.$|^You can't swim in that direction\.$|^You must place it on the ground, before you can drag it anywhere\!$|^You must take it out of .+, before you can drag it anywhere\.$
action send stand;send %previousMovementType %previousMovement when ^You can't do that while kneeling\!$|^You can't do that while lying down\.$|^You can't do that while sitting\!$|^You must be standing to do that\.$
action send retreat;send retreat;send %currentMovement when ^You can't do that while engaged\!$
action math sendQueue subtract 1;if (%verboseMode == 1) then echo sendQueue is now %sendQueue when ^Obvious (paths|exits):|^Ship paths:|^It's pitch dark
action echo Queue is negative! (%sendQueue) when eval(%sendQueue < 0)
var verboseMode 0
#debuglevel 5

if "%0" == "" then {
		put #parse Script Error: AUTOMAPPER [%0] started with no value specified.
		exit
	}
ConvertMovementsToArray:
	var movementList %1
ConvertingToArray:
	shift
	if ("%1" = "") then goto AutomapperStart
	var movementList %movementList|%1
	goto ConvertingToArray

AutomapperStart:
	var previousMovementType
	var PreviousMovement
	if ("$dragItem" != "null") then {
		echo Dragging object: $dragItem
	}
	if (%verboseMode == 1) then echo movementList is %movementList
	var movementCounter 0
	eval movementMaxIndex count("%movementList", "|")
	if (%verboseMode == 1) then echo movementMaxIndex is %movementMaxIndex
	var currentMovementType 
AutomapperMoving:
	if (%verboseMode == 1) then echo Preparing next movement, queue is currently %sendQueue
	var previousMovementType %currentMovementType
	var previousMovement %currentMovement
	var currentMovementType 
	eval currentMovement element("%movementList", %movementCounter)
	if (matchre("%currentMovement", "^(\.|ice|climb|room|rt|search|setroomid|swim|web) ?(.*)")) then {
		var currentMovementType $1
		var currentMovement $2
		if %verboseMode == 1 then echo Special move type: "%currentMovementType"
	}
	# Note: else if isn't reliable here. (Genie bug)
	if (matchre("%currentMovement", "^objsearch (.+) move (.+)")) then {
		var currentMovementType objsearch
		var objectToSearch $1
		var currentMovement $2
		if %verboseMode == 1 then echo Special move type: "%currentMovementType"
	}
	if ("%currentMovementType" != "") then {
		gosub WaitFlushAutomapperCommandQueue
		if %verboseMode == 1 then echo queue should be clear now...
		# adding 1 in anticipation of the next movement.
		math sendQueue add 1
	}
	if ("%currentMovementType" == "climb") then gosub Climb %currentMovement
	if ("%currentMovementType" == "ice") then echo ICE NOT CODED YET
	if ("%currentMovementType" == "objsearch") then {
		put search %objectToSearch
		gosub Move %currentMovement
		goto AutomapperCheckToMoveAgain
	}
	if ("%currentMovementType" == "search") then {
		# Todo: gosub this:
		put search
		wait
		gosub Move %currentMovement
	}
	if ("%currentMovementType" == "setroomid") then gosub MoveSetRoomid %currentMovement
	if ("%currentMovementType" == "swim") then gosub Move %currentMovement
	if ("%currentMovementType" == "room") then gosub Move %currentMovement
	if ("%currentMovementType" == "rt") then gosub Move %currentMovement
	if ("%currentMovementType" == "web") then gosub Move %currentMovement
	if ("%currentMovementType" == ".") then {
		put .%currentMovement
		pause .01
		waiteval !contains("|$scriptlist|", "%|currentMovement.cmd|")
	}
	if ("%currentMovementType" == "") then {
		if ("%previousMovementType" != "") then {
			gosub WaitFlushAutomapperCommandQueue
			math sendQueue add 1
			gosub Move %currentMovement
			if %verboseMode == 1 then echo Last move was special, so gosubbing this move before hyper-mode.
		}
		if ("%previousMovementType" == "") then {
			if (%movementCounter == 0) then {
				if (%verboseMode == 1) then echo this is the first movement, so gosubbing the move the ensure success.
				math sendQueue add 1
				gosub Move %currentMovement
			}
			if (%movementCounter > 0) then {
				gosub WaitOnAutomapperCommandQueue
				if ("$dragItem" == "null") then {
					math sendQueue add 1
					put %currentMovement
				}
				if ("$dragItem" != "null") then {
					math sendQueue add 1
					gosub Move %currentMovement
				}
			}
		}
	}
	if ("%currentMovementType" != "") then {
		if (%verboseMode == 1) then echo Resetting the queue to 0.
		# Note: can't rely on triggers to clear the queue here because a script movement could have multiple movements, which would result in a negative queue depth.
		var sendQueue 0
	}
AutomapperCheckToMoveAgain:
	math movementCounter add 1
	if (%movementCounter <= %movementMaxIndex) then goto AutomapperMoving
AutomapperHasArrived:
	if (%verboseMode == 1) then echo Automapper has arrived, should not see any messages from the SuperQueue
	gosub WaitFlushAutomapperCommandQueue
	if (%verboseMode == 1) then echo Ready to terminate.
	#pause .1
	#echo queue is %sendQueue
	#put #parse Script Info: AUTOMAPPER navigation success.
	# Note: parsing at the end of a script isn't reliable. Sometimes the command doesn't go through.
	#put #parse YOU HAVE ARRIVED
	gosub Echo YOU HAVE ARRIVED
	put #tvar destination null
	exit

AutomapperFailed:
	put #parse Script Error: AUTOMAPPER has encountered an error. Will attempt to re-navigate to $destination if not null.
	# Pause for the movement queue to empty...
	pause 1.5
	if ("$destination" != "null") then {
		put /g $destination
		pause
		exit
	}
	echo Error with automapper. You must re-click to move!
	exit

############################

WaitOnAutomapperCommandQueue:
	var automapperWaitStartTime $gametime
WaitingOnAutomapperCommandQueue:
	if (%sendQueue < %maxSendQueue) then return
	if (%verboseMode == 1) then echo SuperQueue pausing... queue is %sendQueue
	pause .1
	eval automapperElapsedWaitTime $gametime - %automapperWaitStartTime
	# Don't wait more than 120 seconds:
	if (%automapperElapsedWaitTime > 120) then goto WaitingOnAutomapperCommandQueue
	goto AutomapperFailed

WaitFlushAutomapperCommandQueue:
	if (%verboseMode == 1) then echo Flush queue called.
	if (%sendQueue == 0) then return
	if (%verboseMode == 1) then echo pausing until clear, queue is %sendQueue
	pause .1
	goto WaitFlushAutomapperCommandQueue