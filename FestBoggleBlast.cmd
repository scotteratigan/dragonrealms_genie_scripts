#REQUIRE ClearHand.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE Fire.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Go.cmd
#REQUIRE Load.cmd
#REQUIRE Navigate.cmd
#REQUIRE Send.cmd
#REQUIRE Trash.cmd

FestBoggleBlast:
	action var FestBoggleBlast.shotsRemaining $1 when ^You have (\d+) shots remaining\.$
	action var FestBoggleBlast.shotsRemaining 0 when ^You've taken all your shots\.  You should hurry and get your prize\!$
	action var FestBoggleBlast.prize $1 when ^The pumpkin farmer .* and you pull out (.*)\!$
	var FestBoggleBlast.junkItemsList a pumpkin carved anklet|a black blouse of gauze atop silk|some black flannel pajamas|some black silk pants embroidered with white dancing boggles|a black wooden anklet embelished with gold-filled carvings|a black-tinted keyblank|a bone white towel edged in a pattern of dancing boggles|a bright orange bath towel with white boggles embroidered along the hems|a bright orange cloak stitched with deep black webbing around the hemline|a bright orange silk fan embroidered with twin white boggles|a cerulean negeri blossom|a chakrel amulet shaped like a carved pumpkin|a dark blouse of gauze atop silk|a dark brown woolen greatcloak lined with light orange silk brocade|a dark orange cloak embroidered at the edges with black webbing|a deep black towel edged with a pattern of dancing white boggles|a dingy grey robe embroidered with negeri blossoms in a blood-red hue|a dusk-hued robe edged in negerat-set amulets|a fraying coat of dark linen embroidered with like-tone screaming faces|a homespun shirt trailing unfinished hems and loose threads|an innocent-looking doll|some minuscule wooden pumpkins|a niello mirror inset with gloamstone spiders upon its back|an orange satin robe embroidered with a vine of climbing black nightshade|an orange-tinted glass globe shaped to resemble a carved pumpkin|an orange-tinted keyblank|a pair of gold earrings dangling carved orange pumpkins|a pair of large silk wings printed to resemble those of a monarch butterfly|a pair of white leather boots embossed with bright orange pumpkins|a plain tomiek anklet|a polished bronze compass shaped like a spider|a polished flamewood case clasped with a sneering glass pumpkin|a polished platinum mirror with enameled webbing covering the back|a salt-stained brass compass etched with a small pumpkin-headed boggle|a small cambrinth pumpkin carved with a wide grin|a small scarecrow doll with a woolen body stuffed with straw|a smoky soulstone boggle ring|some square-shaped silver spectacles with polished orange-tinted lenses|a spun rainbow cloak woven with a pattern of laughing boggles|a ragged black robe with a spectrolite-inset clasp|a tiny piece of golden stura atulave|a tiny piece of pumpkin-shaped stura atulave|a tomiek-rimmed goggles with dark lenses|a wide cambrinth armband etched with dancing boggles|a roughspun shirt trailing unfinished hems dotted with loose threads
FestBoggleBlasting:
	if ("$SpellTimer.Devour.active" != "1") then gosub FestCastDevour
	if (!contains("$roomobjs", "a skinny boggle")) then {
		gosub Navigate 210 402
		gosub Give farmer 200 dokoras
		#if (!contains("$roomobjs", "a skinny boggle")) then gosub Go door <- can't do this, there are 6 or 7 rooms
		var FestBoggleBlast.prize null
	}
	if (matchre("$roomname", "Boggle Blast, \w+ Room")) then {
		# Putting all this in a conditional because I don't want to get pumpkins in the wrong room - stalls script.
		# I'm not sure what was causing that situation in the first place, and I unfortunately didn't log it.
		gosub Get pumpkin
		gosub Load large slingshot with my pumpkin
		gosub Fire large slingshot
		if (%FestBoggleBlast.shotsRemaining > 0) then goto FestBoggleBlasting
	}
	gosub Move go door
	gosub Get prize
	if ("%FestBoggleBlast.prize" != "null") then {
		if (contains("%FestBoggleBlast.junkItemsList", "%FestBoggleBlast.prize")) then gosub Trash my $righthandnoun
	}
	gosub ClearHand both
	goto FestBoggleBlasting

