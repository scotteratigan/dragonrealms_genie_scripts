#REQUIRE Error.cmd
#REQUIRE Inventory.cmd
#REQUIRE Redeem.cmd
#REQUIRE Stow.cmd
#REQUIRE Trash.cmd

# Usage: .FestTrashOrKeep right
#        .FestTrashOrKeep left
# Determines if an item is trash or not. If not on trash list, stow it. If on trash list, trash it.

# After running, two variables of note:
# FestTrashOrKeep.success 0 or 1 - was the attempt to stow or trash item successful?
# FestTrashOrKeep.saved 0 or 1 - did we attempt to save the item or not?
gosub FestTrashOrKeep %0
exit

FestTrashOrKeep:
	# Crafting materials to trash:
	var FestTrashOrKeep.woodList alder|apple|ash|aspen|balsa|bamboo|birch|cedar|cypress|durian|elm|fir|hemlock|larch|lelori|mahogany|mangrove|maple|moabi|oak|pine|sandalwood|spruce|tamarak|teak|walnut|willow|cherry
	var FestTrashOrKeep.woodNouns branch|limb|log
	var FestTrashOrKeep.metalList bronze|electrum|lead|lumium|nickel|steel|zinc|pewter|iron|tin|silver|brass|copper|platinum|oravir|gold|covellite
	var FestTrashOrKeep.rockList alabaster|andesite|basalt|breccia|coal|darkstone|dolomite|felstone|gabbro|granite|jade|limestone|marble|obsidian|onyx|pumice|quartzite|sandstone|schist|serpentine|soapstone|travertine

	var FestTrashOrKeep.leatherList ape-pelt|arzumos-pelt|azure-scale|bison-hide|black-hide|blood wolf pelt|blue-scale|boar-skin|brown-scale|cave-troll|crimson-scale|damaska-skin|deer-skin|firecat-skin|gargoyle-hide|green-scale|grey-scale|inkhorne-skin|jackal-pelt|la'tami-hide|prereni-skin|rat-skin|rat-pelt|reaver-pelt|red-leucro|red-scale|seal-pelt|sharkskin|sheepskin|troll-skin|white fox pelt|gryphon-pelt|cougar-skin|pivuh-skin|amber-scale|cougar-pelt|shalswar-hide|storm-bull|frog-skin|ogre-skin|dark-scale|ghoul-skin|serpent-skin|bear-pelt|blue-scale|hound-pelt|red-scale|quartz-hide|salt-encrusted
	
	var FestTrashOrKeep.boneStackList badger|bison|bobcat|cougar|crocodile|deer|frog|goblin|kobold|prereni|reaver|sluagh|troll|wolf|jackal|rat|rotting|bear|ghoul|serpent

	var FestTrashOrKeep.clothNounList burlap|cotton|linen|silk|wool|felt
	var FestTrashOrKeep.clothAdjectiveList fine|thin|thick|heavy
	eval FestTrashOrKeep.hand tolower("$0")
	var FestTrashOrKeep.item null
	var FestTrashOrKeep.itemID -1
	gosub Inventory held
	if ("%FestTrashOrKeep.hand" == "left") then {
		var FestTrashOrKeep.item %Inventory.leftHand
		var FestTrashOrKeep.itemID #$lefthandid
	}
	if ("%FestTrashOrKeep.hand" == "right") then {
		var FestTrashOrKeep.item %Inventory.rightHand
		var FestTrashOrKeep.itemID #$righthandid
	}
	if ("%FestTrashOrKeep.item" == "null") then {
		gosub Error Can't determine what to trash or keep - %FestTrashOrKeep.hand appears empty.
		return
	}
	if ("%FestTrashOrKeep.item" == "some Hollow Eve tickets") then {
		action put #echo >Treasure cyan Redeeming $1 tickets. when ^You quickly pocket (.+) tickets\.$
		gosub Redeem %FestTrashOrKeep.itemID
		action remove ^You quickly pocket (.+) tickets\.$
		return
	}
	if (matchre("%FestTrashOrKeep.item", "some .+ dye")) then goto FestTrashItem
	if (matchre("%FestTrashOrKeep.item", "an?.*(%FestTrashOrKeep.metalList) (bar|nugget)")) then goto FestTrashItem
	if (matchre("%FestTrashOrKeep.item", "a deed for a.*(%FestTrashOrKeep.rockList) (boulder|rock|stone|pebble|nugget)")) then goto FestTrashItem
	# Leather is now appearing deeded as well:
	if (matchre("%FestTrashOrKeep.item", "some (%FestTrashOrKeep.leatherList) leather")) then goto FestTrashItem
	if (matchre("%FestTrashOrKeep.item", "a deed for some (%FestTrashOrKeep.leatherList) leather")) then goto FestTrashItem
	# Bone stacks are now appearing deeded as well:
	if (matchre("%FestTrashOrKeep.item", "an? (%FestTrashOrKeep.boneStackList)-bone stack")) then goto FestTrashItem
	if (matchre("%FestTrashOrKeep.item", "a deed for an? (%FestTrashOrKeep.boneStackList)-bone stack")) then goto FestTrashItem
	
	if (matchre("%FestTrashOrKeep.item", "a.* (%FestTrashOrKeep.woodList) (%FestTrashOrKeep.woodNouns)")) then goto FestTrashItem

	if (matchre("%FestTrashOrKeep.item", "some (%FestTrashOrKeep.clothAdjectiveList|) ?(%FestTrashOrKeep.clothNounList) cloth")) then goto FestTrashItem

	if (matchre("%FestTrashOrKeep.item", "(a .+ blouse of gauze atop silk|a .+ doll|a .+ knit woolen cap topped with a fuzzy fringe ball|a .+ silk headscarf|a billowing .+ silk shirt with wide dagged sleeves|a braided leather wristlet interlaced with \S+ beads|a dark \S+ kelp|a dark \S+ rockweed|a flamboyant \S+ mage's robe appliqued with silver-spangled comets|a flamboyant \S+ wizard's robe embroidered with golden stars|a floppy \S+ felt hat trimmed with a \S+ velvet band|a flowing robe of pale \S+ silk|a length of .+ fabric|a low-slung pair of billowy .+ gauze pants gathered close at the ankles|a mask of a .+|a milk chocolate \S+ with currant eyes|a piece of \S+ sharkskin|a polished platinum mirror with enamell?ed webbing covering the back|a simple \S+ ring|a skullcap crafted of .+ silk with colorful beadwork|a spiraling cambrinth armband painted with .+|a steel bodice dagger with a \S+ hilt|a wavy cambrinth earcuff shaped like a .+|an? \S+ kelp|an? \S+ rockweed|some .+ powder|some brushed suede pants lined with \S+ rivets|a carved \S+-shaped ocarina|a hunk of .+ potter's clay)")) then goto FestTrashItem
	if (matchre("%FestTrashOrKeep.item", "a beer-baked ham|a black bandana painted with dancing skeletons|a black felt cuff cut to resemble a bat|a black linen shirt with carved onyx buttons|a black silk surcoat with the crest of the Bards' Guild on the front|a black snail shell|a black wooden anklet embelished with gold-filled carvings|a black-tinted keyblank|a blood-splattered weapon harness with a troll-tooth fringe|a blue-green wool cloak embroidered at the edges with elaborate silver knotwork|a boar tusk necklace strung on a leather thong|a bone white towel edged in a pattern of dancing boggles|a bone-hilted carving knife|a bright orange bath towel with white boggles embroidered along the hems|a bright orange cloak stitched with deep black webbing around the hemline|a bright orange silk fan embroidered with twin white boggles|a broad leather belt with wrought iron studs|a broken femur pitted with holes|a broken ghoul bone|a broken rib|a brown leather eye patch|a calcified humerus bone with one oddly enlarged end|a cambrinth orb shaped like a pumpkin|a carved bone ring|a carved crystal ring shaped like a butcherbird|a carving knife encrusted with dried orange gunk|a cerulean negeri blossom|a chakrel amulet shaped like a carved pumpkin|a charcoal grey lambswool cape embroidered with emerald green silk vines along the hemline|a chocolate caramel muffin|a cobalt-blue lambswool cape embroidered with tiny frogs along the hemline|a coral-hilted carving knife set with a large freshwater pearl|a cotton handkerchief splattered with orange stains|a crimson negeri blossom|a dark brown woolen greatcloak lined with light orange silk brocade|a dark cambrinth bracer engraved with a large spider|a dark orange cloak embroidered at the edges with black webbing|a dark plum felt jacket with shiny silver buttons|a decaying shoe|a deep black towel edged with a pattern of dancing white boggles|a deep red silk ascot fastened with a gold pin|a delicate white marble Tenemlor figurine|a desiccated finger|a dingy grey robe embroidered with negeri blossoms in a blood-red hue|a diopside-eyed cambrinth king snake|a dried serpent husk|a dried yellow slug|a dusk-hued robe edged in negerat-set amulets|a dusky rose damask ascot fastened with a silver pin|a fawn-brown leather belt decorated with steel studs in your grasp|a flagon of Gor'Tog bloodgrog|a flamewood herbal case carved with an elegant floral wreath|a flowing pearl-grey silk sash embroidered with silver sigils|a fossilized lemur skeleton preserved in stone|a fraying coat of dark linen embroidered with like-tone screaming faces|a gaily painted wooden quince|a giant cambrinth radish sculpted from multicolored agate|a gold and diamond horseshoe ring|a gold knotwork torque set with polished ivory|a green linen shirt with carved jade buttons|a green silk garter edged with tiny leaves|a green silk necklace sewn to resemble a vine|a grilled T-bone steak|a grimy snail shell|a half-eaten leather shoe disfigured by abundant bite marks|a heavy steel ring set with a rough-cut obsidian skull|a homespun shirt trailing unfinished hems and loose threads|a honey-glazed ham|a jagged yellow tooth|a lock of greasy hair|a long vulture feather|a long-sleeved pale grey shirt with a row of buttons down the front|a lumpy spleen|a mildewed silk scarf riddled with holes|a misty grey satin gown with a drop-waist bodice|a mocha brown cloak lined with matching satin|a moldy heart-shaped pillow with a tattered silk cover|a moonspun silk robe dyed dark purple with a sun-shaped golden clasp|a mottled brown shin bone|a niello mirror inset with gloamstone spiders upon its back|a pair of blood red suede ankle boots|a pair of gold cufflinks set with carved topaz|a pair of gold earrings dangling carved orange pumpkins|a pair of large silk wings printed to resemble those of a monarch butterfly|a pair of nutmeg-brown leather ankle boots decorated with bronze chains|a pair of obsidian ghoul raven earrings|a pair of pumpkin earrings|a pair of sanguine asini fangs|a pair of skeleton earrings|a pair of slate-blue leather ankle boots decorated with copper chains|a pair of tarnished spectacles|a pair of white leather boots embossed with bright orange pumpkins|a pale undertaker doll soberly dressed in a black frock coat|a patch of dirt-stained linen|a patch of tattered parchment|a petrified corpse grub|a piece of net|a pink-plumed captain's hat of fine black felt|a pitted black tooth|a pitted copper button|a pitted green tooth|a pitted grey tooth|a plain tomiek anklet|a pleated turquoise wool breeches cross-gartered from ankle to knee with pink silk cords|a polished bronze compass shaped like a spider|a polished flamewood case clasped with a sneering glass pumpkin|a polished gold pumpkin charm set with an emerald leaf|a porcelain jackal pin|a pudgy plush beetle|a pumpkin carved anklet|a pumpkin pin|a pumpkin-headed doll dressed in gauzy white rags|a pumpkin-orange scarf edged with green fringe|a pumpkin-shaped charm|a purple scorpion carapace|a purple-plumed captain's hat of fine black felt|a purple-veined lizard tail|a quartz-eyed cambrinth coyote with its hackles raised|a rabbit's foot amulet enameled in red at the severed end|a ragged black robe with a spectrolite-inset clasp|a rencate cambrinth bracer emblazoned with helicoid accents|a roughspun shirt trailing unfinished hems dotted with loose threads|a round cambrinth peach brushed with pale pink glitter|a ruby nose-stud carved to resemble a drop of blood|a ruby-eyed cambrinth viper|a rune-carved stone|a salt-stained brass compass etched with a small pumpkin-headed boggle|a sanguine-hued gutting knife with a punka-wrapped handle|a sapphire ear cuff inlaid with tiny silver stars|a sapphire-eyed cambrinth cobra|a savory hickory-smoked ham|a scarred bank book cover stitched with a threadbare mechanical spider|a scratched jawbone|a ship's biscuit|a shred of dried ratskin|a silver necklace strung with onyx feathers|a silver vulture pin|a silver-etched skinning knife with an black-leucro hide wrapped hilt|a simple cambrinth anklet|a simple velvet hand-puppet|a skull-shaped copper earring|a skull-topped bone ring|a slender black ribbon|a slender bone sliver|a slender bracelet of green silk sewn to resemble a vine|a slice of silky white chocolate rum cheesecake|a sliver of worm-eaten deobar|a small cambrinth pumpkin carved with a wide grin|a small scarecrow doll with a woolen body stuffed with straw|a Smatha Special ham|a smoky soulstone boggle ring|a smooth flat stone|a smooth round stone|a soft green linen trousers edged with black piping|a soft pumpkin muffin|a sparkling pink diamond|a spiced cheese crackers|a spider-painted rock|a spiked axe inlaid along the blade with corroded bronze|a spiraling cambrinth armband|a spun rainbow cloak woven with a pattern of laughing boggles|a squat pumpkin-shaped mug|a string of preserved pumpkin seeds|a tall bottle of turnip mash|a tangle of slimy intestines|a tangled fishing line|a tankard crafted from a misshapen skull|a tarnished gold wedding band accented with ruby chips|a tattered lace veil trimmed with straggly fringe|a tattered scarf|a thick leather belt with steel studs|a thin steel dagger etched with the insignia of the .+ Guild|a torn green ribbon|a triangular piece of cambrinth tart stuffed with chunks of garnet filling|a twisted cambrinth ring|a twisted platinum ring set with an orange beryl pumpkin|a vibrant cire skirt of haematic hues|a violet-red leather belt studded with tiny steel snowflakes|a wavy cambrinth earcuff|a wedge of cambrinth sandwich with dark aventurine watercress|a whiskey-laced cigar|a white silk blouse with tiny black skeletons delicately embroidered on the cuffs|a white silk surcoat with the crest of the Barbarians' Guild on the front|a wide cambrinth armband etched with dancing boggles|a wormwood ring carved to resemble a maggot|a wrinkled purple blouse streaked with dried blood stains|a zombie pin|a zombie-shaped charm|an alabaster scorpion pin|an articulated cambrinth bracer crafted from overlapping scales|an asini-embellished bloody stump amulet|an embossed leather belt with a gold-washed buckle|an inky black trapper's pouch shaped like a panther's paw|an innocent-looking doll|an ivory earcuff carved to resemble a maggot|an ivory skull pin carved with a goofy grin|an obsidian ghoul raven charm|an onyx ape charm|an onyx ghoul raven pin|an orange bandana embroidered with black cats|an orange blown-glass pumpkin suspended from a green silk cord|an orange pumpkin|an orange satin robe embroidered with a vine of climbing black nightshade|an orange-tinted glass globe shaped to resemble a carved pumpkin|an orange-tinted keyblank|any onyx ape charm|some black flannel pajamas|some black silk pants embroidered with white dancing boggles|some bloodshot eyeballs|some bristleback spareribs|some cebi root|some dirt-encrusted sticks|some elaborately interwoven web-like platinum strands strung with tiny crystal beads|some goblin-hide pants|some green crocheted gloves crafted to resemble curling vines|some green socks embroidered with dancing zombies|some hisan flowers|some jadice flowers|some miniature cross-eyed zombies|some miniature dancing skeletons|some miniature fuzzy bats|some miniature pale ghosts|some minuscule wooden pumpkins|some mud-encrusted socks with several frayed holes|some orange pumpkin-shaped jellybeans|some orange socks embroidered with black skeletons|some plush pumpkins with green felt leaves|some roasted pumpkin seeds|some sluagh-hide boots with hammered steel heels|some soft mauve linen trousers edged with black piping|some square-shaped silver spectacles with polished orange-tinted lenses|some tenderfoot venison|some tomiek-rimmed goggles with dark lenses|some white socks embroidered with orange pumpkins|some Yarrel's sun-dried jerky|some yelith root|a faceted forest's heart garnet|a cabochon oval sana'ati heart|a homespun shirt trailing unfinished hems and loose threads|a burnt sienna jar|a Be'ort tear rose|a sleek arm quiver covered in death adder skins|a brown mouse|a field mouse|a plain platinum torque")) then goto FestTrashItem
FestSaveItem:
	put #echo >Treasure cyan Saving: %FestTrashOrKeep.item
	var FestTrashOrKeep.saved 1
	#gosub Stow %FestTrashOrKeep.itemID
	#if (%Stow.success == 1) then var FestTrashOrKeep.success 1
	# Auto-stow behavior was too annoying to keep because we often need to deed items.
	var FestTrashOrKeep.success 1
	return
FestTrashItem:
	put #echo >Treasure gray Discarding: %FestTrashOrKeep.item
	var FestTrashOrKeep.saved 0
	gosub Trash %FestTrashOrKeep.itemID
	if (%Trash.success == 1) then var FestTrashOrKeep.success 1
	return