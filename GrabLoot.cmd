#REQUIRE Loot.cmd
#REQUIRE Nounify.cmd
#REQUIRE Stow.cmd
# todo: add optional equipment looting?
# have character-based loot options with global vars
# $Loot.stowBoxes 0
# $Loot.stowGems 0
# $Loot.stowIngots 0
# etc

#debuglevel 10
gosub GrabLoot %0
exit

GrabLoot:
	var GrabLoot.option $0
	if ("$Loot.treasure" != "null") then gosub GrabLootTreasure
	if ("$Loot.lodgedItems" != "null") then gosub GrabLootLodgedItems
	return

GrabLootLodgedItems:
	var GrabLootLodgedItems.index 0
	eval GrabLootLodgedItems.maxIndex count("$Loot.lodgedItemsList", "|")
GrabbingLootLodgedItems:
	eval GrabLootLodgedItems.currentItem element("$Loot.lodgedItemsList", %GrabLootLodgedItems.index)
	gosub Nounify %GrabLootLodgedItems.currentItem
	var GrabLootLodgedItems.currentNoun %Nounify.noun
	gosub Stow %GrabLootLodgedItems.currentNoun
	math GrabLootLodgedItems.index add 1
	if (%GrabLootLodgedItems.index <= %GrabLootLodgedItems.maxIndex) then goto GrabbingLootLodgedItems
	return

GrabLootTreasure:
	var GrabLootTreasure.index 0
	eval GrabLootTreasure.maxIndex count("$Loot.treasureList", "|")
GrabbingLootTreasure:
	eval GrabLootTreasure.currentItem element("$Loot.treasureList", %GrabLootTreasure.index)
	echo loot: %GrabLootTreasure.currentItem
	# Coins:
	if (matchre("%GrabLootTreasure.currentItem", "\d (bronze|copper|gold|silver) coins?")) then {
		gosub Stow $1 coin
		goto GrabbedSomeLoot
	}
	# Gems:
	if (matchre("%GrabLootTreasure.currentItem", "a (tiny|small|medium|large|huge) (bande|banded|facete|faceted|laced|smoky|spotted|swirled)? ?(amaranth|amber|auburn|azure|bistre|blue|blue-green|blue-purple|brass-colored|bronze-colored|brown|carmine|cerise|cerulean|chartreuse|chestnut|cinnamon|clear|cobalt|copper-colored|cream-colored|crimson|cyan|flax-colored|gold-colored|green|green-yellow|grey|indigo|lavender|lilac|magenta|maroon|mauve|mint green|moss green|moss-green|nomlas|olive|orange|orange-red|peach|pear-colored|periwinkle|pink|purple|purple-blue|red|red-orange|rose|russet|rust-colored|saffron|scarlet|sea-green|sepia|sky blue|skyblue|taupe|teal|turquoise|umber|yellow|yellow-green|yellow-orange) (agate|alexandrite|amethyst|andalusite|aquamarine|beryl|bloodstone|carnelian|chalcedony|chrysoberyl|chrysoprase|chunk of coral|citrine|crystal|diamond|diopside|emerald|garnet|hematite|iolite|jade|kunzite|lapis lazuli|moonstone|morganite|onyx|opal|pearl|peridot|piece of amber|piece of ivory|quartz|ruby|sapphire|spinel|star-stone|sunstone|tanzanite|topaz|tourmaline|tsavorite|zircon)")) then {
		gosub Stow $4
		goto GrabbedSomeLoot
	}
	if (matchre("%GrabLootTreasure.currentItem", "a (tiny|small|medium|large|huge) (chunk of coral|lapis lazuli|piece of amber|piece of ivory|turquoise)")) then {
		gosub Stow $2
		goto GrabbedSomeLoot
	}
	# Boxes:
	if (matchre("%GrabLootTreasure.currentItem", "an? (copper-edged|corroded|cracked|crooked|crust-covered|deeply gouged|dented|dull|greenish|mildewy|misshaped|moldy|mud-stained|pitted|plain|poorly made|reinforced|rotting|rusty|salt-stained|sturdy|worm-eaten) (brass|copper|deobar|driftwood|iron|ironwood|mahogany|oaken|pine|steel|wooden) (box|caddy|casket|chest|coffer|crate|skippet|strongbox|trunk)")) then {
		var lootMobTreasureHandString $righthandid-$lefthandid
		var lootMobTreasureBoxAdjective $2
		var lootMobTreasureBoxNoun $3
		gosub Stow %lootMobTreasureBoxAdjective %lootMobTreasureBoxNoun
		if ("%lootMobTreasureHandString" != "$righthandid-$lefthandid") then {
			if contains("$lefthand $righthand", "%lootMobTreasureBoxNoun") then {
				put #parse Script Error: Unable to stow treasure box, dropping...
				gosub Drop my %lootMobTreasureBoxNoun
			}
		}
		goto GrabbedSomeLoot
	}
	# Forging Materials:
	if (matchre("%GrabLootTreasure.currentItem", "a (tiny|small|medium|large|huge|massive) (brass|bronze|copper|covellite|electrum|gold|iron|lead|nickel|oravir|pewter|silver|steel|zinc) (bar|nugget)")) then {
		# todo: use packets here
		gosub Stow $2 $3
		goto GrabbedSomeLoot
	}
	# Runestones:
	if (matchre("%GrabLootTreasure.currentItem", "an? (axinite|celestite|colorful elbaite|dark asketine|dark azurite|dark silver sraeth|delicate pink erythrite|fiery rhodonite|hafaltu|iheaneu'a|ilmenite|lemicule|pale avaes|selenite|shining calavarite|shiny blue xibaryl|sky-blue imnera|sunstone) runestone")) then {
		# todo: figure out how to specify the runestone with Nounify
		#gosub Stow runestone
		goto GrabbedSomeLoot
	}
	# Arrowheads:
	if (matchre("%GrabLootTreasure.currentItem", "a (barbed|bishop|bodkin|broad-tip|warhead) arrowhead")) then {
		#gosub Stow $1 arrowhead
		#put #parse Script Info: skipping loot: %GrabLootTreasure.currentItem
		goto GrabbedSomeLoot
	}
	# Herbs
	if (matchre("%GrabLootTreasure.currentItem", "(a|an|some) (cebi root|eghmok moss|eghmok potion|georin grass|georin salve|hisan flowers|hisan salve|hulnik grass|ithor potion|ithor root|jadice flower|jadice flowers|junliar stem|junilar stems|muljin sap|nemoih root|nilos grass|nilos salve|plovik leaves|plovik leaf|riolur leaves|sufil sap|yelith root)")) then {
		#gosub Stow $2
		goto GrabbedSomeLoot
	}
	# Lockpicks
	if (matchre("%GrabLootTreasure.currentItem", "an? (ordinary|slim|stout) lockpick")) then {
		# todo: double-check that we can't use adjectives
		#gosub Stow lockpick
		goto GrabbedSomeLoot
	}
	# Cards: 
	if (matchre("%GrabLootTreasure.currentItem", "(a|an|the) .+ card")) then {
		#gosub Stow card
		goto GrabbedSomeLoot
	}
	# Dira:
	if ("%GrabLootTreasure.currentItem" == "an imperial dira")) then {
		#gosub Stow dira
		goto GrabbedSomeLoot
	}
	# Scrolls:
	if (matchre("%GrabLootTreasure.currentItem", "(a seishaka leaf|a smudged parchment|a papyrus roll|a fine scroll|a moldering scroll|a yellowed scroll|a faded vellum|a tattered scroll|a piece of hhr'lav'geluhh bark|a clay tablet|a wax tablet|an ostracon)")) then {
		# todo: hard-code values for scrolls in Nounify for better specificity?
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Rare Loot:
	if (matchre("%GrabLootTreasure.currentItem", "(a brown paper-wrapped package|a kirmhiro draught|a witch ball|a worn and tattered map)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Jewelry:
	if (matchre("%GrabLootTreasure.currentItem", "(a|an|a pair of) (antiquated|battered|bent|brittle|carved|corroded|dark|dented|dull|elaborate|elegant|etched|exquisite|fancy|glistening|intricate|labyrinthine|ornate|polished|pure|scratched|scuffed|shiny|simple|sleek|small|smooth|stained|tarnished|twisted)? ?(anlora-avtoma|brass|bronze|copper|electrum|elven silver|gold|iron|lead|palladium|pewter|platinum|red gold|silver|steel|tin|white gold|white silver)? ?a?n?d? ?(anlora-avtoma|brass|bronze|copper|electrum|elven silver|gold|iron|lead|palladium|pewter|platinum|red gold|silver|steel|tin|white gold|white silver)? ?(anklet|armband|choker|cuff|cufflinks|earstuds|earrings|necklace|pin|ring)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Skeleton Parts:
	if (matchre("%GrabLootTreasure.currentItem", "(a|an) (beisswurm|boar|bobcat|buffalo|cat|cougar|cow|coyote|crocodile|donkey|dove|goblin|headless|heron|hyena|jackal|kobold|leucro|lion|magpie|mongoose|ogre|orc|owl|ox|panther|raccoon|ram|rat|raven|s'lai|shrew|shrike|snowbeast|squirrel|troll|velver|vulture|weasel|welkin|wolf|wolverine|wren) (arm|foreleg|leg|skull|spine|wing)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Event Loot:
	if (matchre("%GrabLootTreasure.currentItem", "a (blunt|broken|chipped|cracked|dull|massive fossilized|needle-thin|sharp|wickedly serrated|wildly jagged) shark's tooth") || matchre("%GrabLootTreasure.currentItem", "(a glowing iron fragment|a taisidon seastar|an orichalcum dragon pendant|some frothy-green oil|some gleaming vardite hinges|some ilomba boards|some mistsilk padding|some taisidon seastars)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Odd Creature Loot / Junk:
	if (matchre("%GrabLootTreasure.currentItem", "(a cambrinth lump|a cambrinth ring|a chipped marble mortar|a colorless albredine ring|a cracked wood-framed mirror|a faded gold ring|a finger bone|a flask of oil|a gold wedding band|a grimy bar of soap|a grimy marble pestle|a half-digested rat head|a hilt|a jaw bone|a jug of brown ale|a knee bone|a lasmodi gwethdesuan|a lead rope|a partially decomposed turnip|a piece of black flint|a rib bone|a skin of sweet red wine|a skull shard|a slender hoof pick|a small honey cake|a soft iron keyblank|a spool of stout thread|a stick of fragrant incense|a stone mortar|a thigh bone|a toe bone|a tuft of hair|a waermodi gwethdesuan|a wax label|a wooden hairbrush|an albredine crystal ring|an altar candle|an ankle bone|an embroidery needle|an iron bar|an iron hoof pick|an iron slug|some feather flights|some flight glue|some holy oil|some jadeite stones|some ju'ladan oil|some kyanite stones|some sacramental wine|some tanning lotion|some thick cotton thread|some tukai stones|some waermodi stones|some wood glue|wax label)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Clothing:
	if (matchre("%GrabLootTreasure.currentItem", "(a|an|a pair of|some) (back-laced|baggy|battle-torn|belted|bulky|buttoned|creased|dark|darned|deep|dyed|elegant|exquisite|faded|fine|fitted|formal|frayed|fringed|graceful|ill-fitting|knee-high|light|long|loose|pale|patched|pressed|pretty|rich|rumpled|scorched|side-laced|small|snug|soft|starched|stiff|sturdy|supple|tailored|tapered|tattered|ugly|well-made|wrinkled)? ?(amaranth|amber|amber-gold|amethyst|apple-red|aqua|aquamarine|ash-grey|auburn|azure|baby blue|beige|bisque|bistre|black|blood-red|blue|blue-green|blue-purple|blue-violet|brass-colored|brick-red|bright green|bright red|bright white|brown|buff brown|burgundy|burnt orange|burnt umber|calico|cardinal-red|carmine|cerise|cerulean|chartreuse|cherry-red|chestnut|cinnamon|cobalt|cobalt-blue|copper-brown|coppery|coral|cream|crimson|crisp white|cyan|desert-beige|dull orange|dusty rose|ebon-hued|ecru|elothean-red|fawn-brown|fiery orange|fiery red|flame-orange|flax-colored|flaxen|forest-green|fuchsia|garnet-red|gold|gold-colored|golden|goldenrod|green|green-yellow|grey|heather-blue|heliotrope|hunter green|ice-blue|icy blue|indigo|jade-green|lavender|leaf-green|lemon-yellow|lilac|lime-green|magenta|maroon|mauve|mint-green|misty blue|misty grey|mocha-brown|moss-green|murky black|navy blue|nomlas|nutmeg-brown|off-white|olive|olive-green|onyx|orange|orange-red|orchid|pastel pink|peach|peacock-blue|pear-colored|pear-green|pear-yellow|pearl-grey|pearl-white|peony-pink|periwinkle|pink|pitch-black|plum|plum-colored|poppy-red|powder-blue|puce|pure white|purple|purple-blue|red|red-orange|rose|rose-colored|russet|rust-colored|sable|saffron|salmon|sandy yellow|scarlet|sea-blue|sea-green|sepia|shadowy ebon|shell-pink|sienna gold|silver|silver-hued|silvery|sky-blue|slate-blue|slate-grey|smoke-grey|snow-white|soft pink|somber black|sorrel-brown|spring green|steel-blue|storm-grey|sunny yellow|tan|tangerine|taupe|tawny gold|teal|translucent|turquoise|twilight purp|umber|verdigris|vermilion|violet|violet-red|viridian|white|wine-colored|wine-red|yellow|yellow-green)? ?(broadcloth|burlap|calico|canvas|cashmere|chenille|cotton|damask|deerskin|faille|felt|gossamer|homespun|jute|lawn|leather|linen|muslin|oilcloth|ratskin|sackcloth|sailcloth|satin|silk|snakeskin|taffeta|tartan|velvet|wolfskin|wool)? ?(belt|blouse|bodice|boots|bracelet|choker|cloak|dress|gamantang|gloves|hat|headband|leggings|odaj|pants|robe|sarong|sash|scarf|shawl|skirt|slippers|socks|tailband|trousers)")) then {
		gosub Nounify %GrabLootTreasure.currentItem
		gosub Stow %Nounify.noun
		goto GrabbedSomeLoot
	}
	# Unknown Item:
	put #parse Script Error: LOOT/S/L unable to categorize item: %GrabLootTreasure.currentItem. Trying to stow in case this is rare!
	gosub Nounify %GrabLootTreasure.currentItem
	gosub Stow %Nounify.noun
	#gosub Get %GrabLootTreasure.currentItem
	#gosub ClearHand %GrabLootTreasure.currentItem
	goto GrabbedSomeLoot
GrabbedSomeLoot:
	math GrabLootTreasure.index add 1
	if (%GrabLootTreasure.index <= %GrabLootTreasure.maxIndex) then goto GrabbingLootTreasure
	return