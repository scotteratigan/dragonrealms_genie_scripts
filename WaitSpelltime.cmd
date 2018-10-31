#REQUIRE Error.cmd

# Ensures that spells reach their minimum prep time.

gosub WaitSpelltime %0
exit

WaitSpelltime:
	var WaitSpelltime.seconds $1
	var WaitSpelltime.success 0
	if (!matchre("%WaitSpelltime.seconds", "^\s*\d+")) then {
		gosub Error WaitSpelltime called from %scriptname but input was not a number. (Entered %WaitSpelltime.seconds).
		return
	}
	if ("$preparedspell" == "None") then {
		gosub Error WaitSpelltime called from %scriptname without any spell prepared!
		return
	}
WaitSpelltimeWaiting:
	if ($spelltime >= %WaitSpelltime.seconds) then {
		var WaitSpelltime.success 1
		return
	}
	if ("$preparedspell" == "None") then {
		gosub Error WaitSpelltime was waiting but spell is no longer being prepared! Returning.
		return
	}
	pause .1
	goto WaitSpelltimeWaiting