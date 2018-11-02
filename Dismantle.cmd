#REQUIRE Send.cmd
#REQUIRE Uninvisible.cmd

gosub Dismantle %0
exit

Dismantle:
	var Dismantle.option $0
	var Dismantle.success 0
Dismantling:
	gosub Send RT "dismantle %Dismantle.option" "^You examine the .+ to determine a weak point from which to start the destruction\.$|^You move your hands in a practiced maneuver, dismantling the .+ and tossing the pieces aside\.$|^You draw in a few deep breaths and then release them in a blood-curdling scream at the .+, which bursts into a cloud of wooden slivers, leaving no trace of its former existence\.$|^You draw in a few deep breaths and then release them in a blood-curdling scream at the .+, which begins to vibrate violently\.  Suddenly, the \w+ bursts in a cloud of metal slivers, leaving no trace of its former existence\.$|^Rolling your shoulders to loosen them, you grasp the .+ between your hands and begin to exert force, pressing inward on the sides\.  You can feel the material of the \w+ resisting, but it is no match for you\.  With a loud .CRACK., the metal of the \w+ compresses into a mangled mass of twisted metal which you toss aside\.$|^Rolling your shoulders to loosen them, you grasp the .+ between your hands and begin to exert force, pressing inward on the sides\.  You can feel the material of the \w+ resisting, but it is no match for you\.  With a loud .CRACK., the \w+ shatters into large splinters which you discard\.$|^You grab the.+ firmly by the sides and hoist it high over your head\.  Eyes narrowed in determination, you slam the .+ down with all your strength as you drive your knee up to meet it\.  The strike is perfect, the box shattering into countless pieces under the force of the impact\.  With a disdainful glance at the splintered remains, you dust the few stray pieces of wood from your knee and hands\.$|^You study the .+ grimly, looking for a weakness in the metal construction\.  Satisfied, you grab the it firmly by the sides and hoist it high over your head\.  Eyes narrowed in determination, you slam the .+ down with all your strength as you drive your knee up to meet it\.  The strike is perfect, the metal folding under the force of the impact\.  With a disdainful glance at the twisted heap, you casually toss it aside\.$" "^\[Unable to locate the object you specified\.\]$|^You must be holding the object you wish to dismantle\.$|^You must first disarm the .+ before you attempt to dismantle it\.$|^You must first open the .+ before you attempt to dismantle it\.$|^You can not dismantle the .+ while there is something inside it\.  If you'd like to dump the contents and try again, repeat this request in the next 15 seconds\.$|^You can't seem to manage that while staying out of sight\.$|^You repeatedly bash the .+ against your head to no avail\.  Perhaps you should try something else as you do not think anyone will be impressed\.$|^While bunnies are useful for a great many things, they do not as a general rule serve well as janitors\.$|^Don't be silly, you know nothing of caravans\.$|^You examine the .+ considering how to dismantle it using your jaw power and rapidly reconsider\.$|^You claw futilely at the .+ with your fingers\.$|^You make a feeble attempt to crush the .+ to no avail\.$|^What precisely do you plan on firing at the .+\?$|^You hold the .+ and try to focus on it with all your might\. You think you feel the .+ shudder, but quickly realize it was just you shuddering from holding your breath\. You're just not sure you have it in you\.|^You bounce up and down like a little kid\.$|^You chant a quiet prayer to the Immortals, calling upon your devotion to their service\.  Apparently they aren't taking requests of this nature right now\.$|^You consider it, but decide you'd really better not\.$|^You study the .+, but wouldn't even know where to begin\.$|^You can shriek at the .+ all you want, but you get the impression it does not care\.$|^Try as you may, you just end up fumbling around clumsily\.$|^You make a feeble attempt to stomp the .+ into smithereens, but fail to make any perceptible progress\.$|^You feel really silly thumping the .+\.  What did you expect would happen\?$|^You whistle at the .+\.$" ""
	if ("%Send.success" == "1") then {
		var Dismantle.success 1
		return
	}
	if (matchre("%Send.response", "^You can not dismantle the .+ while there is something inside it\.  If you'd like to dump the contents and try again, repeat this request in the next 15 seconds\.$")) then goto Dismantling
	if ("%Send.response" == "You can't seem to manage that while staying out of sight.") then {
		gosub Uninvisible
		if ($invisible == 0) then goto Dismantling
	}
	return