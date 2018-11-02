#REQUIRE Dig.cmd
#REQUIRE Navigate.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Trash.cmd
#REQUIRE Inventory.cmd

FestGraveEarth:
	action var FestGraveEarth.currentPrize $1 when ^You swish your hand around in the open grave, pulling back when you catch (.+) in your hand\.$
	action var FestGraveEarth.currentPrize $1 when ^In your right hand, you are carrying (.+)\.$
	var FestGraveEarth.junkItems a calcified humerus bone with one oddly enlarged end|a broken femur pitted with holes|a carved crystal ring shaped like a butcherbird|some dirt-encrusted sticks|a sparkling pink diamond|a tarnished gold wedding band accented with ruby chips|a misty grey satin gown with a drop-waist bodice|some mud-encrusted socks with several frayed holes|a tattered lace veil trimmed with straggly fringe|a wrinkled purple blouse streaked with dried blood stains|a flamewood herbal case carved with an elegant floral wreath|a fossilized lemur skeleton preserved in stone|an innocent-looking doll|a moldy heart-shaped pillow with a tattered silk cover|a pale undertaker doll soberly dressed in a black frock coat|a scarred bank book cover stitched with a threadbare mechanical spider|a simple velvet hand-puppet|a slender bone sliver|a weasel-faced doll|an alabaster scorpion pin|a black snail shell|a broken ghoul bone|a broken rib|a carved bone ring|a delicate white marble Tenemlor figurine|a desiccated finger|a dried yellow slug|a grimy snail shell|a jagged yellow tooth|a lock of greasy hair|a long vulture feather|a lumpy spleen|a mottled brown shin bone|a pair of tarnished spectacles|a patch of dirt-stained linen|a patch of tattered parchment|a petrified corpse grub|a pitted black tooth|a pitted green tooth|a pitted grey tooth|a porcelain jackal pin|a purple scorpion carapace|a purple-veined lizard tail|a rune-carved stone|a scratched jawbone|a shred of dried ratskin|a silver vulture pin|a skull-shaped copper earring|a skull-topped bone ring|a slender black ribbon|a sliver of worm-eaten deobar|a smooth flat stone|a smooth round stone|a spider-painted rock|a tangle of slimy intestines|a dried serpent husk
	var FestGraveEarth.bodyPartList skull|arm|foreleg|wing|leg|tail
	var FestGraveEarth.animalList bear|beisswurm|boar|bobcat|buffalo|cat|cow|cougar|coyote|crocodile|donkey|dove|goblin|heron|hyena|jackal|kobold|leucro|lion|magpie|mongoose|ogre|orc|owl|ox|panther|raccoon|ram|rat|raven|s'lai|shrew|shrike|snowbeast|squirrel|troll|velver|vulture|weasel|welkin|wolf|wolverine
	if ("$lefthand $righthand" != "Empty Empty") then {
		gosub Inventory held
		gosub FestGraveEarthCheckToSaveItem
	}
FestGraveEarthing:
	gosub ClearHand both
	if ("$lefthand $righthand" != "Empty Empty") then {
		echo Can't run script - item in hand!
		put #beep
		put #flash
		exi
t	}
	gosub Navigate 210 23
	var FestGraveEarth.currentPrize null
	gosub Dig pile
	gosub FestGraveEarthCheckToSaveItem
	goto FestGraveEarth

FestGraveEarthCheckToSaveItem:
	if ("$lefthand $righthand" == "Empty Empty") then return
	if (contains("%FestGraveEarth.junkItems", "%FestGraveEarth.currentPrize")) then {
		put #echo >ScriptLog gray Not saving: %FestGraveEarth.currentPrize
		gosub Trash #$righthandid
		return
	}
	if (matchre("%FestGraveEarth.currentPrize", "%FestGraveEarth.animalList %FestGraveEarth.bodyPartList")) then {
		put #echo >ScriptLog gray Not saving: %FestGraveEarth.currentPrize
		gosub Trash #$righthandid
		return
	}
	put #echo >ScriptLog cyan Saving item: %FestGraveEarth.currentPrize
	return