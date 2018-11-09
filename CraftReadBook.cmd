#REQUIRE ClearHand.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Read.cmd
#REQUIRE Turn.cmd

# Usage: CraftReadBook discipline item
# Example: CraftReadBook weaponsmithing a metal briquet

gosub CraftReadBook %0
exit

CraftReadBook:
	var CraftReadBook.discipline $1
	var CraftReadBook.item $0
	var CraftReadBook.success 0
	var CraftReadBook.chapter 0
	var CraftReadBook.page 0
	eval CraftReadBook.item replacere("%CraftReadBook.item", "^%CraftReadBook.discipline ", "")
	if (!contains("$lefthand $righthand", "%CraftReadBook.discipline book")) then {
		gosub ClearHand both
		gosub Get my %CraftReadBook.discipline book
	}
	if (!contains("$lefthand $righthand", "%CraftReadBook.discipline book")) then {
		gosub Error Could not find proper book to study!
		return
	}
	if ("%CraftReadBook.discipline" == "weaponsmithing") then {
		if (contains("|a light throwing axe|a metal adze|a metal baselard|a metal briquet|a metal carving knife|a metal curlade|a metal cutlass|a metal dagger|a metal dao|a metal dart|a metal falcata|a metal foil|a metal gladius|a metal hand axe|a metal hanger|a metal hatchet|a metal iltesh|a metal jambiya|a metal kasai|a metal katar|a metal koummya|a metal kris|a metal kythe|a metal leaf blade sword|a metal mambeli|a metal misericorde|a metal nehlata|a metal oben|a metal parang|a metal pasabas|a metal poignard|a metal pugio|a metal rapier|a metal sabre|a metal sashqa|a metal scimitar|a metal short sword|a metal shotel|a metal stiletto|a metal sunblade|a metal takouba|a metal telek|a metal throwing dagger|a metal thrusting blade|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 1
		if (contains("|a metal abassi|a metal arzfilt|a metal back-sword|a metal battle axe|a metal broadsword|a metal cinquedea|a metal condottiere|a metal degesse|a metal falchion|a metal hunting sword|a metal hurling axe|a metal kudalata|a metal longsword|a metal namkomba|a metal nehdalata|a metal nimsha|a metal recade|a metal robe sword|a metal round axe|a metal schiavona|a metal spatha|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 2
		if (contains("|a metal claymore|a metal double axe|a metal flamberge|a metal greataxe|a metal greatsword|a metal igorat axe|a metal karambit|a metal kaskara|a metal marauder blade|a metal periperiu sword|a metal shh'oi'ata|a metal twin-point axe|a metal two-handed sword|a metal warring axe|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 3
		if (contains("|a flanged metal mace|a metal belaying pin|a metal bludgeon|a metal boko|a metal bola|a metal boomerang|a metal bulhawf|a metal club|a metal cosh|a metal cudgel|a metal cuska|a metal garz|a metal gavel|a metal hand mace|a metal hand mallet|a metal hhr'tami|a metal k'trinni sha-tai|a metal komno|a metal mace|a metal mallet|a metal marlingspike|a metal prod|a metal scepter|a metal throwing club|a metal war club|a metal war hammer|a metal zubke|a ridged metal gauntlet|a short metal hammer|a spiked metal club|a spiked metal gauntlet|a spiked metal hammer|a spiked metal mace|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 4
		if (contains("|a double-headed hammer|a heavy metal chain|a heavy metal mace|a heavy metal mallet|a hurlable war hammer|a metal ball and chain|a metal greathammer|a metal hara|a metal hhr'ata|a metal horseman's flail|a metal imperial war hammer|a metal morning star|a metal sledgehammer|a metal throwing hammer|a metal throwing mallet|a metal ukabi|a spiked ball and chain|a spiked metal hara|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 5
		if (contains("|a giant metal mallet|a heavy sledgehammer|a metal akabo|a metal dire mace|a metal footman's flail|a metal maul|a metal two-headed hammer|a metal vilks kodur|a metal war mattock|double-sided ball and chain|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 6
		if (contains("|a light metal spear|a metal allarh|a metal awgravet ava|a metal awl pike|a metal bardiche|a metal coresca|a metal duraka skefne|a metal fauchard|a metal glaive|a metal guisarme|a metal halberd|a metal hunthsleg|a metal ilglaiks skefne|a metal javelin|a metal khuj|a metal lance|a metal lochaber axe|a metal military fork|a metal ngalio|a metal partisan|a metal pike|a metal pole axe|a metal ranseur|a metal scythe|a metal spear|a metal spetum|a metal tzece|a metal voulge|a two-pronged halberd|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 7
		if (contains("|a metal cane|some metal knee spikes|a metal nightstick|some spiked metal knuckles|a metal quarterstaff|some metal hand claws|some metal knuckles|a weighted staff|a metal pike staff|some metal elbow spikes|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 8
		if (contains("|a metal throwing spike|a metal boarding axe|a metal bastard sword|a metal half-handled riste|a metal war sword|a thin-bladed metal fan|a metal broadaxe|a metal riste|a metal bar mace|a thick-bladed metal fan|a metal splitting maul|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 9
	}
	if ("%CraftReadBook.discipline" == "blacksmithing") then {
		if (contains("|a ball-peen hammer|a ball-peen mallet|a curved metal shovel|a diagonal-peen hammer|a diagonal-peen mallet|a flat-headed metal pickaxe|a metal cross-peen hammer|a narrow metal pickaxe|a slender metal pickaxe|a square metal shovel|a stout metal pickaxe|a straight-peen hammer|a straight-peen mallet|a sturdy metal shovel|a tapered metal shovel|a weighted metal pickaxe|a wide metal shovel|some angular metal tongs|some articulated tongs|some box-jaw tongs|some curved metal tongs|some flat-bladed tongs|some metal bolt tongs|some segmented tongs|some straight metal tongs|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 2
		if (contains("|a coarse metal rasp|a flat metal rasp|a flat metal shaper|a long metal drawknife|a metal beveled wood shaper|a metal curved bone saw|a metal curved wood saw|a metal jagged wood shaper|a metal serrated bone saw|a metal serrated wood saw|a metal slender bone saw|a metal slender wood saw|a metal straight bone saw|a metal straight wood saw|a metal tapered bone saw|a metal tapered wood saw|a rough metal wood shaper|a sharpened metal drawknife|a short metal drawknife|a sturdy metal drawknife|a tapered metal rasp|a textured metal rasp|a thin metal rasp|some curved metal pliers|some curved metal rifflers|some elongated rifflers|some hooked metal pliers|some long metal chisels|some plain metal pliers|some reinforced chisels|some rough metal pliers|some sharpened chisels|some short metal chisels|some square metal rifflers|some squat metal rifflers|some sturdy metal chisels|some thick metal pliers|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 3
		if (contains("|a compact metal awl|a curved hide scraper|a detailed yardstick|a flat metal yardstick|a metal hide scraper|a narrow metal awl|a pointed metal awl|a rectangular yardstick|a serrated hide scraper|a slender metal awl|a stout metal yardstick|some bent metal scissors|some curved metal scissors|some knobby sewing needles|some plain sewing needles|some polished knitting needles|some ribbed sewing needles|some serrated scissors|some smooth knitting needles|some squat knitting needles|some straight metal scissors|some tapered knitting needles|some thin sewing needles|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 4
		if (contains("|a flat mixing stick|a flat pestle|a grooved mixing stick|a grooved pestle|a metal brazier|a round mixing stick|a round pestle|a small metal brazier|a square wire sieve|a tapered mixing stick|a tapered pestle|a trapezoidal wire sieve|a triangular wire sieve|an oblong wire sieve|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 5
		if (contains("|a back scratcher|a large metal flask|a large metal horseshoe|a metal ankle band|a metal armband|a metal backtube|a metal bolt box|a metal chest|a metal crown|a metal flask|a metal flights box|a metal headdress|a metal herbal case|a metal horseshoe|a metal instrument case|a metal jewelry box|a metal lockpick case|a metal lockpick ring|a metal mask|a metal oil lantern|a metal origami case|a metal razor|a metal starchart tube|a metal talisman case|a metal torque|a shallow metal cup|a short metal mug|a slender metal rod|a small metal flask|a soft metal keyblank|a tall metal mug|some metal barbells|some metal clippers|", "|%CraftReadBook.item|")) then var CraftReadBook.chapter 6

	}
	# todo: add other disciplines here
	if (%CraftReadBook.chapter == 0) then {
		gosub Error Chapter not defined for this item or discipline.
		return
	}
	gosub Turn my book to chapter %CraftReadBook.chapter
	if (%Turn.success == 0) then {
		gosub Error Unknown error turning to chapter
		return
	}
	gosub Read my %CraftReadBook.discipline book
	if (%Read.success == 0) then {
		gosub Error Unknown error reading book
		return
	}
	# Ok, I need to figure out the chapter here... wow this is really easy!
	if (matchre("%Read.text", "Page (\d+): %CraftReadBook.item")) then var CraftReadBook.page $1
	if (%CraftReadBook.page == 0) then {
		gosub Error Couldn't find item in this chapter
		return
	}
	gosub Turn my book to page %CraftReadBook.page
	if (%Turn.success == 0) then {
		gosub Error Unknown error turning to correct page
		return
	}
	var CraftReadBook.haftRequired 0
	var CraftReadBook.hiltRequired 0
	var CraftReadBook.longCordRequired 0
	var CraftReadBook.longPoleRequired 0
	var CraftReadBook.shortCordRequired 0
	var CraftReadBook.volumeRequired 0
	gosub Read my %CraftReadBook.discipline book
	if (%Read.success == 0) then {
		gosub Error Unknown error reading book
		return
	}
	
	if (contains("%Read.text", "(1) finished wooden haft")) then {
		echo Haft required.
		var CraftReadBook.haftRequired 1
	}
	if (contains("%Read.text", "(1) finished wooden hilt")) then {
		echo Hilt required.
		var CraftReadBook.hiltRequired 1
	}
	if (contains("%Read.text", "(1) finished long leather cord")) then {
		echo Long cord required.
		var CraftReadBook.longCordRequired 1
	}
	if (contains("%Read.text", "(1) finished long wooden pole")) then {
		echo Long pole required.
		var CraftReadBook.longPoleRequired 1
	}
	if (contains("%Read.text", "(1) finished short leather cord")) then {
		echo Short cord required.
		var CraftReadBook.shortCordRequired 1
	}
	if (matchre("%Read.text", "\(1\) refined metal ingot \((\d+) volume\)")) then {
		var CraftReadBook.volumeRequired $1
		echo Ingot volume required: %CraftReadBook.volumeRequired
	}
	var CraftReadBook.success 1
	return