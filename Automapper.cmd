#REQUIRE Climb.cmd
#REQUIRE Move.cmd


# Assumes global $moveSuccessStrings (set by running Init.cmd)
# Note: the standard gosub template would be difficult to implement here.
# We can't pass %0 into $0 because the quotes are stripped out, rendering a movement string that can't be deciphered.
# Example: "go path east north climb wall south"

var maxSendQueue 3
var sendQueue 0
action instant goto AutomapperFailed when ^You can't do that while engaged\!$|^You can't go there\.$|^I could not find what you were referring to\.$|^What were you referring to\?$|^You can't do that\.$|^You must place it on the ground, before you can drag it anywhere\!$|^You must take it out of .+, before you can drag it anywhere\.$
action math sendQueue subtract 1;if %verboseMode == 1 then echo sendQueue is now %sendQueue when $moveSuccessStrings
action echo Queue is negative! (%sendQueue) when eval(%sendQueue < 0)
var verboseMode 0

if "%0" == "" then {
		put #parse Script Error: AUTOMAPPER [%0] started with no value specified.
		exit
	}
ConvertMovementsToArray:
	var movementList %1
ConvertingToArray:
	shift
	if "%1" = "" then goto AutomapperStart
	var movementList %movementList|%1
	goto ConvertingToArray

AutomapperStart:
	if "$dragItem" != "null" then {
		echo Dragging object: $dragItem
	}
	if %verboseMode == 1 then echo movementList is %movementList
	var movementCounter 0
	eval movementMaxIndex count("%movementList", "|")
	if %verboseMode == 1 then echo movementMaxIndex is %movementMaxIndex
	var currentMovementType normal
AutomapperMoving:
	if %verboseMode == 1 then echo Preparing next movement, queue is currently %sendQueue
	var previousMovementType %currentMovementType
	var currentMovementType normal
	eval currentMovement element("%movementList", %movementCounter)
	if matchre("%currentMovement", "^(\.|ice|climb|room|rt|search|swim) ?(.*)") then {
		var currentMovementType $1
		var currentMovement $2
		if %verboseMode == 1 then echo Special move type: "%currentMovementType"
	}

	# Note: else if isn't reliable here. Genie bug:
	if "%currentMovementType" != "normal" then {
		gosub WaitFlushAutomapperCommandQueue
		if %verboseMode == 1 then echo queue should be clear now...
		# adding 1 in anticipation of the next movement.
		math sendQueue add 1
	}
	if "%currentMovementType" == "climb" then gosub Climb %currentMovement
	if "%currentMovementType" == "ice" then echo ICE NOT CODED YET
	if "%currentMovementType" == "swim" then gosub Move %currentMovement
	if "%currentMovementType" == "room" then gosub Move %currentMovement
	if "%currentMovementType" == "rt" then gosub Move %currentMovement
	if "%currentMovementType" == "." then {
		put .%currentMovement
		pause .01
		waiteval !contains("|$scriptlist|", "%|currentMovement.cmd|")
	}
	if "%currentMovementType" == "normal" then {
		if "%previousMovementType" != "normal" then {
			gosub WaitFlushAutomapperCommandQueue
			math sendQueue add 1
			gosub Move %currentMovement
			if %verboseMode == 1 then echo Last move was special, so gosubbing this move before hyper-mode.
		}
		if "%previousMovementType" == "normal" then {
			if %movementCounter == 0 then {
				if %verboseMode == 1 then echo this is the first movement, so gosubbing the move the ensure success.
				math sendQueue add 1
				gosub Move %currentMovement
			}
			if %movementCounter > 0 then {
				gosub WaitOnAutomapperCommandQueue
				if "$dragItem" == "null" then {
					math sendQueue add 1
					put %currentMovement
				}
				if "$dragItem" != "null" then {
					math sendQueue add 1
					gosub Move %currentMovement
				}
			}
		}
	}
	if "%currentMovementType" != "normal" then {
		if %verboseMode == 1 then echo Resetting the queue to 0.
		# Note: can't rely on triggers to clear the queue here because a script movement could have multiple movements, which would result in a negative queue depth.
		var sendQueue 0
	}
	math movementCounter add 1
	if %movementCounter <= %movementMaxIndex then goto AutomapperMoving
AutomapperHasArrived:
	if %verboseMode == 1 then echo Automapper has arrived, should not see any messages from the SuperQueue
	gosub WaitFlushAutomapperCommandQueue
	if %verboseMode == 1 then echo Ready to terminate.
	#pause .1
	#echo queue is %sendQueue
	#put #parse Script Info: AUTOMAPPER navigation success.
	put #parse YOU HAVE ARRIVED
	#put #parse YOU HAVE ARRIVED
	delay .01
	exit

AutomapperFailed:
	put #parse Script Error: AUTOMAPPER has encountered an error.
	echo Error with automapper! Aborting.
	exit

############################

WaitOnAutomapperCommandQueue:
	if %sendQueue < %maxSendQueue then return
	if %verboseMode == 1 then echo SuperQueue pausing... queue is %sendQueue
	pause .1
	goto WaitOnAutomapperCommandQueue

WaitFlushAutomapperCommandQueue:
	if %verboseMode == 1 then echo Flush queue called.
	if %sendQueue == 0 then return
	if %verboseMode == 1 then echo pausing until clear, queue is %sendQueue
	pause .1
	goto WaitFlushAutomapperCommandQueue