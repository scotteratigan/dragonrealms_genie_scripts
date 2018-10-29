
gosub Uninvisible %0
exit

Uninvisible:
	var Uninvisible.option $0
	# Todo: add temp option which just drops/picks up a coin
	var Uninvisible.success 0
Uninvisibleing:
	if ("$SpellTimer.KhriSilence.active" == "1") then {
		send khri stop silence
		wait
		# todo: add khri verb script
	}
	if ("$SpellTimer.EyesoftheBlind.active" == "1") then {
		send release eotb
		wait
		# todo: add release verb script
	}
	if ("$SpellTimer.RefractiveField.active" == "1") then {
		send release rf
		wait
		# todo: add release verb script
	}
	if ($invisible == 1) then {
		echo Todo: add coin drop/pickup here.
	}
	if ($invisible == 0) then var Uninvisible.success 1
	#gosub Send RT "template %Uninvisible.option" "SUCCESS MESSAGES" "FAIL MESSAGES" "WARNING MESSAGES"
	#if ("%Send.success" == "1") then var Uninvisible.success 1
	return