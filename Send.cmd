#REQUIRE Error.cmd
#REQUIRE Information.cmd
#REQUIRE Stand.cmd
#REQUIRE WaitStun.cmd
#REQUIRE Warning.cmd
# The base gosub to Send commands to the game.
gosub Send %0
exit

Send:
	var Send.type $1
	# Send.type options:
	# Q - Performs minimal checks before Sending command for speed/efficiency. No auto-stand, or magic/performance checks.
	# RT - Additional checks before Sending for reliability and to take advantage of RT for prepping spells or playing music.
	# W - Waits for the prompt after success or fail message. Useful for when the best match is not the last line and triggered variable values might not be set yet. (example: assess and ^You assess your combat situation...)
	var Send.command $2
	var Send.successText $3
	var Send.failText $4
	var Send.warningText $5
	var Send.attempts 0
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
	if ("%Send.successText" == "") then {
		gosub Error Send.cmd called with no success text.
		return
	}
	if ("%Send.failText" == "") then {
		var Send.failText ^null$
	}
	if ("%Send.warningText" == "") then {
		var Send.warningText ^null$
	}
	var Send.response null
	if ($stunned) then gosub WaitStun
	if ("%Send.type" != "Q") then {
		if (!$standing) then gosub STAND
		# todo: add magic check here.
		# todo: add playing music check here.
	}
Sending:
	math Send.attempts add 1
	pause .01
	matchre Sending ^\.\.\.wait.*$|^Sorry, you may.*$|^Sorry, system is slow.*$|^You don't seem to be able to move to do that.*$|^It's all a blur.*$|^You're unconscious\!.*$|^You are still stunned.*$|^You can't do that while entangled in a web\.$|^You struggle against the shadowy webs to no avail\.$|^You attempt that, but end up getting caught in an invisible box\.$|^Strangely, you don't feel like fighting right now\.$|^You can't seem to do that right now\!$|^You can't do that while entangled in a web\.$
	matchre SendStopPlaying ^You are a bit too busy performing to do that\.$|^You are concentrating too much upon your performance to do that\.$
	matchre SendStand ^You must stand first\.$
	matchre SendFail ^Please rephrase that command\.$|^I could not find what you were referring to\.$|^What were you referring to\?$|^I don't understand what you're referring to\.$|^I don't know what you are referring to\.$|^You can't do that\.$|^There is no need for violence here\.$|^You really shouldn't be loitering in here\.$
	# Following is invoked in get/put/drop and possibly other verbs:
	if (%Send.attempts < 10) then matchre Sending ^Something appears different about .+, perhaps try doing that again\.$
	matchre SendGetVisible ^That would ruin your hiding place\.$
	matchre SendFail %Send.failText
	matchre SendWarning %Send.warningText
	matchre SendOk %Send.successText
	put %Send.command
	matchwait 10
SendFail:
	# Need to strip out brackets because it causes issues later with regexp comparisons. Alternately, could escape them... hmm.
	var Send.response $0
	var Send.success 0
	#gosub EscapeSpecialCharacters Send.response - disabled for now, easier to chain if statements or contains
	gosub Error %Send.response
	if ("%Send.type" == "W") then pause .08
	return
SendGetVisible:
	if ($hidden) then {
		# todo: invoke an unhide script when completed.
		put shiver
		pause
	}
	if ($invisible) then {
		# todo: invoke all this once I have khri verb and release verb done.
		if ("$SpellTimer.EyesoftheBlind.active" == "1") then put release EOTB
		if ("$$SpellTimer.RefractiveField.active" == "0") then put release RF
		if ("$$SpellTimer.KhriSilence.active" == "1") then put khri stop silence
		pause	
	}
	goto Sending
SendOk:
	# Slightly repetitive but we need to store $0 asap to avoid an overwrite from a trigger firing.
	var Send.response $0
	var Send.success 1
	#gosub EscapeSpecialCharacters Send.response
	gosub Information %Send.response
	if ("%Send.type" == "W") then pause .08
	return
SendWarning:
	var Send.response $0
	var Send.success 1
	gosub Warning %Send.response
	if ("%Send.type" == "W") then pause .08
	return
SendStopPlaying:
	# todo: implement stop.cmd. In this instance, probably run it in-line versus bloating all other scripts.
	put stop play
	goto Sending
SendStand:
	gosub Stand
	goto Sending

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