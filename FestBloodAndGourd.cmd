#REQUIRE Break.cmd
#REQUIRE ClearHand.cmd
#REQUIRE East.cmd
#REQUIRE FestCastDevour.cmd
#REQUIRE Grab.cmd
#REQUIRE Health.cmd
#REQUIRE Information.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE Redeem.cmd
#REQUIRE Tend.cmd
#REQUIRE TendBleeders.cmd
#REQUIRE TendLeeches.cmd
#REQUIRE Trash.cmd
#REQUIRE West.cmd

#You fall to your knees as the world spins around and around!
#You feel your strength ebb away.
#The world seems to blur a moment.

# And FUCK you can die:
#  A bright flash of light barely gives you enough warning to attempt to shield yourself with your arms before the orange pumpkin explodes, throwing you backward and to the ground!

# Full text:
#[festbloodandgourd]: break my pumpkin
#Reconnecter: Death detected.
#You manage to clutch onto a striated orange pumpkin as you gasp your last!
#You feel the knowledge of the Vigor and Rage of the Clans spells slip from your mind.
#Your death cry echoes in your brain as it quickly dawns on you that you have just died!  Already, you feel the tug of eternity upon your soul and you struggle to remain tied to this world.
#
#A chill takes the seat of your soul as your remaining spiritual strength bleeds away.  You feel the eyes of the gods upon you, eager to receive you in judgment.
#
#Your body will decay beyond its ability to hold your soul in 266 minutes.
#  A bright flash of light barely gives you enough warning to attempt to shield yourself with your arms before the orange pumpkin explodes, throwing you backward and to the ground!
#
#Reconnecter: Death detected via game-text.
#DEAD> [festbloodandgourd]: stand
#You are a ghost!  You must wait until someone resurrects you, or you decay.  Either way, it won't be long now! (HELP for more details).

# Todo: add coin withdraw?
# > grab vat
# A nearby attendant explains, "Perhaps you should return when you have enough coins."

FestBloodAndGourd:
	action var FestBloodAndGourd.currentPrize $1 when ^.*Noticing something in the pumpkin debris, you reach down and pick up (.+)\!$

	#var FestBloodAndGourd.trashList carving knife|black bandana|felt cuff|cotton handkerchief|crocheted gloves|silk garter|green socks|pink rosecloth fabric|tattered black fabric|mask|zombie mask|skull mask|pumpkin mask|silk scarf|orange bandana|orange socks|pumpkin-orange scarf|white socks|asini-embellished amulet|leather wristlet|leather wristlet|horseshoe ring|knotwork torque|silk necklace|steel ring|ivory earcuff|skull pin|raven charm|ape charm|blown-glass pumpkin|gold cufflinks|obsidian ghoul raven earrings|pumpkin earrings|asini fangs|skeleton earrings|pumpkin charm|pumpkin pin|pumpkin-shaped charm|rabbit's foot amulet|ruby nose-stud|ear cuff|silver necklace|slender bracelet|pumpkin seeds|platinum ring|wormwood ring|zombie pin|zombie-shaped charm|bloodshot eyeballs|cross-eyed zombies|dancing skeletons|fuzzy bats|pale ghosts|plush pumpkins|leather shoe|pumpkin-shaped jellybeans|plush beetle|pumpkin-headed doll|roasted seeds|pumpkin muffin|pumpkin-shaped mug|tankard|decaying shoe|piece of net|copper button|fishing line|tattered scarf|green ribbon
	var FestBloodAndGourd.trashList a bone-hilted carving knife|a carving knife encrusted with dried orange gunk|a coral-hilted carving knife set with a large freshwater pearl|a black bandana painted with dancing skeletons|a black felt cuff cut to resemble a bat|a cotton handkerchief splattered with orange stains|some green crocheted gloves crafted to resemble curling vines|a green silk garter edged with tiny leaves|some green socks embroidered with dancing zombies|a length of pink rosecloth fabric|a length of tattered black fabric|a mask of a cross-eyed zombie|a mask of a grinning skull|a mask of a scowling pumpkin|a mildewed silk scarf riddled with holes|an orange bandana embroidered with black cats|some orange socks embroidered with black skeletons|a pumpkin-orange scarf edged with green fringe|some white socks embroidered with orange pumpkins|an asini-embellished bloody stump amulet|a braided leather wristlet interlaced with garnet beads|a braided leather wristlet interlaced with jade beads|a gold and diamond horseshoe ring|a gold knotwork torque set with polished ivory|a green silk necklace sewn to resemble a vine|a heavy steel ring set with a rough-cut obsidian skull|an ivory earcuff carved to resemble a maggot|an ivory skull pin carved with a goofy grin|an obsidian ghoul raven charm|any onyx ape charm|an orange blown-glass pumpkin suspended from a green silk cord|a pair of gold cufflinks set with carved topaz|a pair of obsidian ghoul raven earrings|a pair of pumpkin earrings|a pair of sanguine asini fangs|a pair of skeleton earrings|a polished gold pumpkin charm set with an emerald leaf|a pumpkin pin|a pumpkin-shaped charm|a rabbit's foot amulet enameled in red at the severed end|a ruby nose-stud carved to resemble a drop of blood|a sapphire ear cuff inlaid with tiny silver stars|a silver necklace strung with onyx feathers|a slender bracelet of green silk sewn to resemble a vine|a string of preserved pumpkin seeds|a twisted platinum ring set with an orange beryl pumpkin|a wormwood ring carved to resemble a maggot|a zombie pin|a zombie-shaped charm|some bloodshot eyeballs|some miniature cross-eyed zombies|some miniature dancing skeletons|some miniature fuzzy bats|some miniature pale ghosts|some plush pumpkins with green felt leaves|a cambrinth orb shaped like a pumpkin|a dark cambrinth bracer engraved with a large spider|a giant cambrinth radish sculpted from multicolored agate|a round cambrinth peach brushed with pale pink glitter|a triangular piece of cambrinth tart stuffed with chunks of garnet filling|a wedge of cambrinth sandwich with dark aventurine watercress|a half-eaten leather shoe disfigured by abundant bite marks|some orange pumpkin-shaped jellybeans|a pudgy plush beetle|a pumpkin-headed doll dressed in gauzy white rags|some roasted pumpkin seeds|a sanguine-hued gutting knife with a punka-wrapped handle|a soft pumpkin muffin|a squat pumpkin-shaped mug|a tankard crafted from a misshapen skull|a decaying shoe|a piece of net|a pitted copper button|a tangled fishing line|a tattered scarf|a torn green ribbon
	gosub ClearHand both
	if ("$SpellTimer.Devour.active" != "1") then gosub FestCastDevour
	gosub Navigate 210 388
	gosub TendLeeches
	if ($bleeding == 1) then gosub TendBleeders
	gosub Grab vat
	if ("$lefthand $righthand" == "Empty Empty") then goto FestBloodAndGourd
	gosub West
	var FestBloodAndGourd.currentPrize null
	gosub Break my pumpkin
	gosub East
	if ("$lefthand $righthand" != "Empty Empty") then {
		if ("%FestBloodAndGourd.currentPrize" == "null") then {
			put #flash
			put #beep
			echo PRIZE NOT DETECTED!
			exit
		}
	}
	gosub FestBloodAndGourdSaveOrTrashItem	
	if ("%Break.response" == "Grasping the orange pumpkin firmly, you bring it up swiftly into your forehead.  With a grimace, you wipe off pumpkin residue on the back of your forearm.  A bright flash of light barely gives you enough warning to attempt to shield yourself with your arms before the orange pumpkin explodes, throwing you backward and to the ground!") then {
		gosub Health
		pause 20
	}
	goto FestBloodAndGourd

FestBloodAndGourdSaveOrTrashItem:
	if ("$lefthand $righthand" == "Empty Empty") then return
	if ("%FestBloodAndGourd.currentPrize" == "null") then return
	if ("%FestBloodAndGourd.currentPrize" == "some Hollow Eve tickets") then {
		gosub Redeem tickets
		return
	}
	if (matchre("%FestBloodAndGourd.trashList", "%FestBloodAndGourd.currentPrize")) then {
		put #echo >ScriptLog gray Not saving junk: %FestBloodAndGourd.currentPrize
		gosub Trash #$righthandid
		return
	}
	put #beep
	put #flash
	put #echo >ScriptLog cyan Found something good: %FestBloodAndGourd.currentPrize
	echo Found something good: %FestBloodAndGourd.currentPrize
	gosub ClearHand both
	return