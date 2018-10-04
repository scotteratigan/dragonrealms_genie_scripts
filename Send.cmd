# Includes Send, WAIT_RT, WAIT_STUN, Waitforre
#REQUIRE Error.cmd
#REQUIRE Stand.cmd
gosub Send $0
exit

Send:
	# The base gosub to Send commands to the game.
		var Send.type $1
		# Q - Performs minimal checks before Sending command for speed/efficiency. No auto-stand, or magic/performance checks.
		# RT - Additional checks before Sending for reliability and to take advantage of RT for prepping spells or playing music.
		# W - Waits for the prompt after success or fail message. Useful for when the best match is not the last line and triggered variable values might not be set yet. (example: assess and ^You assess your combat situation...)
		var Send.command $2
		var successText $3
		var failText $4
		if ("%Send.command" == "") then {
			gosub Error Send.command is blank, nothing to Send.
			return
		}
		eval Send.length length("%Send.command")
		if (%Send.length > 1023) then {
			# Will get auto-booted if we Send 1024 characters in one command. No legitimate use either, by the way.
			eval Send.command substr("%Send.command", 0, 1023);
			gosub Error Send.command is shortened to 1023 characters. WTF are you doing?
		}
		if ("%failText" == "") then {
			echo Warning, Send called without fail text.
			var failText ^null$
		}
		var Send.response null
		if ($stunned) then gosub WAIT_STUN
		if ("%Send.type" != "Q") then {
			if (!$standing) then gosub STAND
			# todo: add magic check here.
			# todo: add playing music check here.
		}
	Sending:
		pause .01
		matchre Sending $RetryStrings
		matchre SendStopPlaying ^You are a bit too busy performing to do that\.$|^You are concentrating too much upon your performance to do that\.$
		matchre SendStand ^You must stand first\.$
		matchre SendFail ^Please rephrase that command\.$|^I could not find what you were referring to\.$|^What were you referring to\?$|^There is no need for violence here\.$|^You can't do that\.$
		matchre SendFail %failText
		matchre SendOk %successText
		put %Send.command
		matchwait 10
	SendFail:
		# Need to strip out brackets because it causes issues later with regexp comparisons. Alternately, could escape them... hmm.
		var Send.response $0
		#gosub EscapeSpecialCharacters Send.response - disabled for now, easier to chain if statements or contains
		var Send.success 0
		if ("%Send.type" == "W") then pause .08
		return
	SendOk:
		# Slightly repetitive but we need to store $0 asap to avoid an overwrite from a trigger firing.
		var Send.response $0
		#gosub EscapeSpecialCharacters Send.response
		var Send.success 1
		if ("%Send.type" == "W") then pause .08
		return
	SendStopPlaying:
		put stop play
		goto Sending
	SendStand:
		gosub STAND
		goto Sending

WAIT_RT:
	# not included in Send gosub / not currently in use
	put echo Waiting on rt...
	pause .1
	if ($roundtime > 0) then goto WAIT_RT
	return

WAIT_STUN:
	#put echo Waiting on stun...
	pause .1
	if ($stunned) then goto WAIT_STUN
	return

Waitforre:
	# implements the equivalent of matchwait x, using matchwait
	var Waitforre.seconds $1
		var Waitforre.matchres $2
		var Waitforre.response null
		# todo: optional activity while advancing (appraise? throw weapon?)
		matchre Waitforre_RETURN %Waitforre.matchres
		matchwait %Waitforre.seconds
		gosub Error Waitforre %Waitforre.seconds %Waitforre.matchres TIMEOUT.
	Waitforre_RETURN:
		var Waitforre.response $0
		return

EscapeSpecialCharacters:
	# Escapes regexp characters. Quotes are removed by Genie already.
	var EscapeSpecialCharacters.varName $1
	var EscapeSpecialCharacters.value %$1
	# JS replace is necessary because Genie can't handle replacere with variable (can't capture text with parens and put it back into string):
	<%
	var myString = getVar("EscapeSpecialCharacters.value");
	echo("myString: " + myString);
	myString = myString.replace(/([\[\]\\\.\+\-\(\)])/g, '\\$1');
	echo("myString: " + myString);
	setVar("EscapeSpecialCharacters.value", myString);
	%>
	# Following 'hack' is to remove the quotes that surround the new string:
	eval EscapeSpecialCharacters.value replace(%EscapeSpecialCharacters.value, "~", "~")
	var %EscapeSpecialCharacters.varName %EscapeSpecialCharacters.value
	return