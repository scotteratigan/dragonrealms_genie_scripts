#REQUIRE Send.cmd

gosub Appraise %0
exit

Appraise:
	var Appraise.command $0
	var Appraise.success 0
	# Subs taken from https://elanthipedia.play.net/Genie_numerical_appraisal_subs
	put #subs {^(\s+)no (\w+) damage\$\$} {\$1no (0/28) \$2 damage} {appraise}
	put #subs {^(\s+)dismal (\w+) damage\$} {\$1dismal (1/28) \$2 damage} {appraise}
	put #subs {^(\s+)poor (\w+) damage\$} {\$1poor (2/28) \$2 damage} {appraise}
	put #subs {^(\s+)low (\w+) damage\$} {\$1low (3/28) \$2 damage} {appraise}
	put #subs {^(\s+)somewhat fair (\w+) damage\$} {\$1somewhat fair (4/28) \$2 damage} {appraise}
	put #subs {^(\s+)fair (\w+) damage\$} {\$1fair (5/28) \$2 damage} {appraise}
	put #subs {^(\s+)somewhat moderate (\w+) damage\$} {\$1somewhat moderate (6/28) \$2 damage} {appraise}
	put #subs {^(\s+)moderate (\w+) damage\$} {\$1moderate (7/28) \$2 damage} {appraise}
	put #subs {^(\s+)somewhat heavy (\w+) damage\$} {\$1somewhat heavy (8/28) \$2 damage} {appraise}
	put #subs {^(\s+)heavy (\w+) damage\$} {\$1heavy (9/28) \$2 damage} {appraise}
	put #subs {^(\s+)very heavy (\w+) damage\$} {\$1very heavy (10/28) \$2 damage} {appraise}
	put #subs {^(\s+)great (\w+) damage\$} {\$1great (11/28) \$2 damage} {appraise}
	put #subs {^(\s+)very great (\w+) damage\$} {\$1very great (12/28) \$2 damage} {appraise}
	put #subs {^(\s+)severe (\w+) damage\$} {\$1severe (13/28) \$2 damage} {appraise}
	put #subs {^(\s+)very severe (\w+) damage\$} {\$1very severe (14/28) \$2 damage} {appraise}
	put #subs {^(\s+)extreme (\w+) damage\$} {\$1extreme (15/28) \$2 damage} {appraise}
	put #subs {^(\s+)very extreme (\w+) damage\$} {\$1very extreme (16/28) \$2 damage} {appraise}
	put #subs {^(\s+)mighty (\w+) damage\$} {\$1mighty (17/28) \$2 damage} {appraise}
	put #subs {^(\s+)very mighty (\w+) damage\$} {\$1very mighty (18/28) \$2 damage} {appraise}
	put #subs {^(\s+)bone-crushing (\w+) damage\$} {\$1bone-crushing (19/28) \$2 damage} {appraise}
	put #subs {^(\s+)very bone-crushing (\w+) damage\$} {\$1very bone-crushing (20/28) \$2 damage} {appraise}
	put #subs {^(\s+)devastating (\w+) damage\$} {\$1devastating (21/28) \$2 damage} {appraise}
	put #subs {^(\s+)very devastating (\w+) damage\$} {\$1very devastating (22/28) \$2 damage} {appraise}
	put #subs {^(\s+)overwhelming (\w+) damage\$} {\$1overwhelming (23/28) \$2 damage} {appraise}
	put #subs {^(\s+)annihilating (\w+) damage\$} {\$1annihilating (24/28) \$2 damage} {appraise}
	put #subs {^(\s+)obliterating (\w+) damage\$} {\$1obliterating (25/28) \$2 damage} {appraise}
	put #subs {^(\s+)demolishing (\w+) damage\$} {\$1demolishing (26/28) \$2 damage} {appraise}
	put #subs {^(\s+)catastrophic (\w+) damage\$} {\$1catastrophic (27/28) \$2 damage} {appraise}
	put #subs {^(\s+)god-like (\w+) damage\$} {\$1god-like (28/28) \$2 damage} {appraise}
	put #subs {^(\s+)no (\w+) damage increase\$} {\$1no (0/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)poor (\w+) damage increase\$} {\$1poor (1/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)low (\w+) damage increase\$} {\$1low (2/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)fair (\w+) damage increase\$} {\$1fair (3/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)moderate (\w+) damage increase\$} {\$1moderate (4/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)heavy (\w+) damage increase\$} {\$1heavy (5/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)great (\w+) damage increase\$} {\$1great (6/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)severe (\w+) damage increase\$} {\$1severe (7/7) \$2 damage increase} {appraise}
	put #subs {^(\s+)no (\w+) damage with affinity for (\w+) attacks\$} {\$1no (0/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)dismal (\w+) damage with affinity for (\w+) attacks\$} {\$1dismal (1/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)poor (\w+) damage with affinity for (\w+) attacks\$} {\$1poor (2/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)low (\w+) damage with affinity for (\w+) attacks\$} {\$1low (3/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)somewhat fair (\w+) damage with affinity for (\w+) attacks\$} {\$1somewhat fair (4/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)fair (\w+) damage with affinity for (\w+) attacks\$} {\$1fair (5/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)somewhat moderate (\w+) damage with affinity for (\w+) attacks\$} {\$1somewhat moderate (6/28) \$2 damage with affinity for \$3 attacks} put {appraise}
	put #subs {^(\s+)moderate (\w+) damage with affinity for (\w+) attacks\$} {\$1moderate (7/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)somewhat heavy (\w+) damage with affinity for (\w+) attacks\$} {\$1somewhat heavy (8/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)heavy (\w+) damage with affinity for (\w+) attacks\$} {\$1heavy (9/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very heavy (\w+) damage with affinity for (\w+) attacks\$} {\$1very heavy (10/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)great (\w+) damage with affinity for (\w+) attacks\$} {\$1great (11/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very great (\w+) damage with affinity for (\w+) attacks\$} {\$1very great (12/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)severe (\w+) damage with affinity for (\w+) attacks\$} {\$1severe (13/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very severe (\w+) damage with affinity for (\w+) attacks\$} {\$1very severe (14/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)extreme (\w+) damage with affinity for (\w+) attacks\$} {\$1extreme (15/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very extreme (\w+) damage with affinity for (\w+) attacks\$} {\$1very extreme (16/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)mighty (\w+) damage with affinity for (\w+) attacks\$} {\$1mighty (17/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very mighty (\w+) damage with affinity for (\w+) attacks\$} {\$1very mighty (18/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)bone-crushing (\w+) damage with affinity for (\w+) attacks\$} {\$1bone-crushing (19/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very bone-crushing (\w+) damage with affinity for (\w+) attacks\$} {\$1very bone-crushing (20/28) \$2 damage with affinity for \$3 attacks} put {appraise}
	put #subs {^(\s+)devastating (\w+) damage with affinity for (\w+) attacks\$} {\$1devastating (21/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)very devastating (\w+) damage with affinity for (\w+) attacks\$} {\$1very devastating (22/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)overwhelming (\w+) damage with affinity for (\w+) attacks\$} {\$1overwhelming (23/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)annihilating (\w+) damage with affinity for (\w+) attacks\$} {\$1annihilating (24/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)obliterating (\w+) damage with affinity for (\w+) attacks\$} {\$1obliterating (25/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)demolishing (\w+) damage with affinity for (\w+) attacks\$} {\$1demolishing (26/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)catastrophic (\w+) damage with affinity for (\w+) attacks\$} {\$1catastrophic (27/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)god-like (\w+) damage with affinity for (\w+) attacks\$} {\$1god-like (28/28) \$2 damage with affinity for \$3 attacks} {appraise}
	put #subs {^(\s+)no (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1no (0/28) \$2 damage.\$3The \$4 \$5 seems to put resonate with violent energy.} {appraise}
	put #subs {^(\s+)dismal (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1dismal (1/28) \$2 damage.\$3The \$4 \$5 seems 	put to resonate with violent energy.} {appraise}
	put #subs {^(\s+)poor (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1poor (2/28) \$2 damage.\$3The \$4 \$5 seems to 	put resonate with violent energy.} {appraise}
	put #subs {^(\s+)low (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1low (3/28) \$2 damage.\$3The \$4 \$5 seems to put resonate with violent energy.} {appraise}
	put #subs {^(\s+)somewhat fair (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1somewhat fair (4/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)fair (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1fair (5/28) \$2 damage.\$3The \$4 \$5 seems to 	put resonate with violent energy.} {appraise}
	put #subs {^(\s+)somewhat moderate (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1somewhat moderate (6/28) \$2 put damage.\$3The \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)moderate (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1moderate (7/28) \$2 damage.\$3The \$4 \$5 put seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)somewhat heavy (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1somewhat heavy (8/28) \$2 put damage.\$3The \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)heavy (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1heavy (9/28) \$2 damage.\$3The \$4 \$5 seems to 	put resonate with violent energy.} {appraise}
	put #subs {^(\s+)very heavy (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very heavy (10/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)great (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1great (11/28) \$2 damage.\$3The \$4 \$5 seems to 	put resonate with violent energy.} {appraise}
	put #subs {^(\s+)very great (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very great (12/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)severe (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1severe (13/28) \$2 damage.\$3The \$4 \$5 seems 	put to resonate with violent energy.} {appraise}
	put #subs {^(\s+)very severe (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very severe (14/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)extreme (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1extreme (15/28) \$2 damage.\$3The \$4 \$5 put seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)very extreme (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very extreme (16/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)mighty (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1mighty (17/28) \$2 damage.\$3The \$4 \$5 seems 	put to resonate with violent energy.} {appraise}
	put #subs {^(\s+)very mighty (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very mighty (18/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)bone-crushing (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1bone-crushing (19/28) \$2 put damage.\$3The \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)very bone-crushing (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very bone-crushing (20/28) \$2 	put damage.\$3The \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)devastating (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1devastating (21/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)very devastating (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1very devastating (22/28) \$2 put damage.\$3The \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)overwhelming (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1overwhelming (23/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)annihilating (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1annihilating (24/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)obliterating (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1obliterating (25/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)demolishing (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1demolishing (26/28) \$2 damage.\$3The \$4 	put \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)catastrophic (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1catastrophic (27/28) \$2 damage.\$3The 	put \$4 \$5 seems to resonate with violent energy.} {appraise}
	put #subs {^(\s+)god-like (\w+) damage\.(\s+)The (.*) (point|edge|face) seems to resonate with violent energy\.\$} {\$1god-like (28/28) \$2 damage.\$3The \$4 \$5 	put seems to resonate with violent energy.} {appraise}
	put #subs {(is|are) not (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 not (0/17) 	put \$2} {appraise}
	put #subs {(is|are) terribly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 terribly 	put (1/17) \$2} {appraise}
	put #subs {(is|are) dismally (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 dismally 	put (2/17) \$2} {appraise}
	put #subs {(is|are) poorly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 poorly put (3/17) \$2} {appraise}
	put #subs {(is|are) inadequately (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put inadequately (4/17) \$2} {appraise}
	put #subs {(is|are) fairly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 fairly put (5/17) \$2} {appraise}
	put #subs {(is|are) decently (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 decently 	put (6/17) \$2} {appraise}
	put #subs {(is|are) reasonably (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put reasonably (7/17) \$2} {appraise}
	put #subs {(is|are) soundly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 soundly 	put (8/17) \$2} {appraise}
	put #subs {(is|are) well (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 well (9/17) 	put \$2} {appraise}
	put #subs {(is|are) very well (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 very 	put well (10/17) \$2} {appraise}
	put #subs {(is|are) extremely well (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 	put extremely well (11/17) \$2} {appraise}
	put #subs {(is|are) excellently (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put excellently (12/17) \$2} {appraise}
	put #subs {(is|are) superbly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 superbly 	put (13/17) \$2} {appraise}
	put #subs {(is|are) incredibly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put incredibly (14/17) \$2} {appraise}
	put #subs {(is|are) amazingly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put amazingly (15/17) \$2} {appraise}
	put #subs {(is|are) unbelievably (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put unbelievably (16/17) \$2} {appraise}
	put #subs {(is|are) perfectly (designed for improving the force|balanced and|suited to gaining extra attack power|suited for adding attack power)} {\$1 put perfectly (17/17) \$2} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is extremely low for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is put extremely low (1/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is very low for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is very low 	put (2/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is somewhat low for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is put somewhat low (3/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is average for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is average put (4/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is somewhat high for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is put somewhat high (5/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is very high for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is very high 	put (6/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is exceptionally high for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is 	put exceptionally high (7/8) for a \$2 of this type.} {appraise}
	put #subs {^The (.*) appears set for a draw strength that is extremely high for a (\w+) of this type\.\$} {The \$1 appears set for a draw strength that is put extremely high (8/8) for a \$2 of this type.} {appraise}
	put #subs {it imposes no maneuvering hindrance\.\$} {it imposes no (0/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes insignificant maneuvering hindrance\.\$} {it imposes insignificant (1/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes trivial maneuvering hindrance\.\$} {it imposes trivial (2/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes light maneuvering hindrance\.\$} {it imposes light (3/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes minor maneuvering hindrance\.\$} {it imposes minor (4/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes fair maneuvering hindrance\.\$} {it imposes fair (5/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes mild maneuvering hindrance\.\$} {it imposes mild (6/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes moderate maneuvering hindrance\.\$} {it imposes moderate (7/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes noticeable maneuvering hindrance\.\$} {it imposes noticeable (8/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes high maneuvering hindrance\.\$} {it imposes high (9/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes significant maneuvering hindrance\.\$} {it imposes significant (10/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes great maneuvering hindrance\.\$} {it imposes great (11/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes extreme maneuvering hindrance\.\$} {it imposes extreme (12/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes debilitating maneuvering hindrance\.\$} {it imposes debilitating (13/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes overwhelming maneuvering hindrance\.\$} {it imposes overwhelming (14/15) maneuvering hindrance.} {appraise}
	put #subs {it imposes insane maneuvering hindrance\.\$} {it imposes insane (15/15) maneuvering hindrance.} {appraise}
	put #subs {(offers|to) no (to|protection\.\$)} {\$1 no (0/26) \$2} {appraise}
	put #subs {(offers|to) extremely terrible (to|protection\.\$)} {\$1 extremely terrible (1/26) \$2} {appraise}
	put #subs {(offers|to) terrible (to|protection\.\$)} {\$1 terrible (2/26) \$2} {appraise}
	put #subs {(offers|to) dismal (to|protection\.\$)} {\$1 dismal (3/26) \$2} {appraise}
	put #subs {(offers|to) very poor (to|protection\.\$)} {\$1 very poor (4/26) \$2} {appraise}
	put #subs {(offers|to) poor (to|protection\.\$)} {\$1 poor (5/26) \$2} {appraise}
	put #subs {(offers|to) rather low (to|protection\.\$)} {\$1 rather low (6/26) \$2} {appraise}
	put #subs {(offers|to) low (to|protection\.\$)} {\$1 low (7/26) \$2} {appraise}
	put #subs {(offers|to) fair (to|protection\.\$)} {\$1 fair (8/26) \$2} {appraise}
	put #subs {(offers|to) better than fair (to|protection\.\$)} {\$1 better than fair (9/26) \$2} {appraise}
	put #subs {(offers|to) moderate (to|protection\.\$)} {\$1 moderate (10/26) \$2} {appraise}
	put #subs {(offers|to) moderately good (to|protection\.\$)} {\$1 moderately good (11/26) \$2} {appraise}
	put #subs {(offers|to) good (to|protection\.\$)} {\$1 good (12/26) \$2} {appraise}
	put #subs {(offers|to) very good (to|protection\.\$)} {\$1 very good (13/26) \$2} {appraise}
	put #subs {(offers|to) high (to|protection\.\$)} {\$1 high (14/26) \$2} {appraise}
	put #subs {(offers|to) very high (to|protection\.\$)} {\$1 very high (15/26) \$2} {appraise}
	put #subs {(offers|to) great (to|protection\.\$)} {\$1 great (16/26) \$2} {appraise}
	put #subs {(offers|to) very great (to|protection\.\$)} {\$1 very great (17/26) \$2} {appraise}
	put #subs {(offers|to) exceptional (to|protection\.\$)} {\$1 exceptional (18/26) \$2} {appraise}
	put #subs {(offers|to) very exceptional (to|protection\.\$)} {\$1 very exceptional (19/26) \$2} {appraise}
	put #subs {(offers|to) impressive (to|protection\.\$)} {\$1 impressive (20/26) \$2} {appraise}
	put #subs {(offers|to) very impressive (to|protection\.\$)} {\$1 very impressive (21/26) \$2} {appraise}
	put #subs {(offers|to) amazing (to|protection\.\$)} {\$1 amazing (22/26) \$2} {appraise}
	put #subs {(offers|to) incredible (to|protection\.\$)} {\$1 incredible (23/26) \$2} {appraise}
	put #subs {(offers|to) tremendous (to|protection\.\$)} {\$1 tremendous (24/26) \$2} {appraise}
	put #subs {(offers|to) unbelievable (to|protection\.\$)} {\$1 unbelievable (25/26) \$2} {appraise}
	put #subs {(offers|to) god-like (to|protection\.\$)} {\$1 god-like (26/26) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) no (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 no (0/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) insignificant (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 insignificant (1/8) \$2} 	put {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) light (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 light (2/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) fair (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 fair (3/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) moderate (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 moderate (4/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) high (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 high (5/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) great (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 great (6/8) \$2} {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) overwhelming (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 overwhelming (7/8) \$2} 	put {appraise}
	put #subs {(appears? to impose|maneuvering hindrance and) insane (maneuvering hindrance and|stealth hindrance, offering:)} {\$1 insane (8/8) \$2} {appraise}
	put #subs {^(\s+)poor protection and} {\$1poor (1/15) protection and} {appraise}
	put #subs {^(\s+)low protection and} {\$1low (2/15) protection and} {appraise}
	put #subs {^(\s+)fair protection and} {\$1fair (3/15) protection and} {appraise}
	put #subs {^(\s+)moderate protection and} {\$1moderate (4/15) protection and} {appraise}
	put #subs {^(\s+)good protection and} {\$1good (5/15) protection and} {appraise}
	put #subs {^(\s+)very good protection and} {\$1very good (6/15) protection and} {appraise}
	put #subs {^(\s+)high protection and} {\$1high (7/15) protection and} {appraise}
	put #subs {^(\s+)very high protection and} {\$1very high (8/15) protection and} {appraise}
	put #subs {^(\s+)great protection and} {\$1great (9/15) protection and} {appraise}
	put #subs {^(\s+)very great protection and} {\$1very great (10/15) protection and} {appraise}
	put #subs {^(\s+)extreme protection and} {\$1extreme (11/15) protection and} {appraise}
	put #subs {^(\s+)exceptional protection and} {\$1exceptional (12/15) protection and} {appraise}
	put #subs {^(\s+)incredible protection and} {\$1incredible (13/15) protection and} {appraise}
	put #subs {^(\s+)amazing protection and} {\$1amazing (14/15) protection and} {appraise}
	put #subs {^(\s+)unbelievable protection and} {\$1unbelievable (15/15) protection and} {appraise}
	put #subs {protection and very poor damage absorption} {protection and very poor (1/17) damage absorption} {appraise}
	put #subs {protection and poor damage absorption} {protection and poor (2/17) damage absorption} {appraise}
	put #subs {protection and low damage absorption} {protection and low (3/17) damage absorption} {appraise}
	put #subs {protection and somewhat fair damage absorption} {protection and somewhat fair (4/17) damage absorption} {appraise}
	put #subs {protection and fair damage absorption} {protection and fair (5/17) damage absorption} {appraise}
	put #subs {protection and moderate damage absorption} {protection and moderate (6/17) damage absorption} {appraise}
	put #subs {protection and good damage absorption} {protection and good (7/17) damage absorption} {appraise}
	put #subs {protection and very good damage absorption} {protection and very good (8/17) damage absorption} {appraise}
	put #subs {protection and high damage absorption} {protection and high (9/17) damage absorption} {appraise}
	put #subs {protection and very high damage absorption} {protection and very high (10/17) damage absorption} {appraise}
	put #subs {protection and great damage absorption} {protection and great (11/17) damage absorption} {appraise}
	put #subs {protection and very great damage absorption} {protection and very great (12/17) damage absorption} {appraise}
	put #subs {protection and extreme damage absorption} {protection and extreme (13/17) damage absorption} {appraise}
	put #subs {protection and exceptional damage absorption} {protection and exceptional (14/17) damage absorption} {appraise}
	put #subs {protection and incredible damage absorption} {protection and incredible (15/17) damage absorption} {appraise}
	put #subs {protection and amazing damage absorption} {protection and amazing (16/17) damage absorption} {appraise}
	put #subs {protection and unbelievable damage absorption} {protection and unbelievable (17/17) damage absorption} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) unhindered and your stealth (would|to) be} {If 	put you were only wearing \$1 \$2 unhindered (0/14) and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) barely hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 barely (1/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) minimally hindered and your stealth (would|to) 	put be} {If you were only wearing \$1 \$2 minimally (2/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) insignificantly hindered and your stealth (put would|to) be} {If you were only wearing \$1 \$2 insignificantly (3/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) lightly hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 lightly (4/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) fairly hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 fairly (5/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) somewhat hindered and your stealth (would|to) 	put be} {If you were only wearing \$1 \$2 somewhat (6/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) moderately hindered and your stealth (would|to) 	put be} {If you were only wearing \$1 \$2 moderately (7/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) rather hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 rather (8/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) very hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 very (9/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) highly hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 highly (10/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) greatly hindered and your stealth (would|to) be} 	put {If you were only wearing \$1 \$2 greatly (11/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) extremely hindered and your stealth (would|to) 	put be} {If you were only wearing \$1 \$2 extremely (12/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) overwhelmingly hindered and your stealth (put would|to) be} {If you were only wearing \$1 \$2 overwhelmingly (13/14) hindered and your stealth \$3 be} {appraise}
	put #subs {^If you were only wearing (.*) (your maneuvering would be|you could expect your maneuvering to be) insanely hindered and your stealth (would|to) 	put be} {If you were only wearing \$1 \$2 insanely (14/14) hindered and your stealth \$3 be} {appraise}
	put #subs {and your stealth (would|to) be unhindered\.\$} {and your stealth \$1 be unhindered (0/14).} {appraise}
	put #subs {and your stealth (would|to) be barely hindered\.\$} {and your stealth \$1 be barely (1/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be minimally hindered\.\$} {and your stealth \$1 be minimally (2/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be insignificantly hindered\.\$} {and your stealth \$1 be insignificantly (3/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be lightly hindered\.\$} {and your stealth \$1 be lightly (4/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be fairly hindered\.\$} {and your stealth \$1 be fairly (5/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be somewhat hindered\.\$} {and your stealth \$1 be somewhat (6/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be moderately hindered\.\$} {and your stealth \$1 be moderately (7/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be rather hindered\.\$} {and your stealth \$1 be rather (8/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be very hindered\.\$} {and your stealth \$1 be very (9/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be highly hindered\.\$} {and your stealth \$1 be highly (10/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be greatly hindered\.\$} {and your stealth \$1 be greatly (11/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be extremely hindered\.\$} {and your stealth \$1 be extremely (12/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be overwhelmingly hindered\.\$} {and your stealth \$1 be overwhelmingly (13/14) hindered.} {appraise}
	put #subs {and your stealth (would|to) be insanely hindered\.\$} {and your stealth \$1 be insanely (14/14) hindered.} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently unhindered and your stealth is} {But considering all the 	put armor and shields you are wearing or carrying, you are currently unhindered (0/14) and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently barely hindered and your stealth is} {But considering all 	put the armor and shields you are wearing or carrying, you are currently barely (1/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently minimally hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently minimally (2/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently insignificantly hindered and your stealth is} {But put considering all the armor and shields you are wearing or carrying, you are currently insignificantly (3/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently lightly hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently lightly (4/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently fairly hindered and your stealth is} {But considering all 	put the armor and shields you are wearing or carrying, you are currently fairly (5/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently somewhat hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently somewhat (6/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently moderately hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently moderately (7/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently rather hindered and your stealth is} {But considering all 	put the armor and shields you are wearing or carrying, you are currently rather (8/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently very hindered and your stealth is} {But considering all 	put the armor and shields you are wearing or carrying, you are currently very (9/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently highly hindered and your stealth is} {But considering all 	put the armor and shields you are wearing or carrying, you are currently highly (10/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently greatly hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently greatly (11/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently extremely hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently extremely (12/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently overwhelmingly hindered and your stealth is} {But put considering all the armor and shields you are wearing or carrying, you are currently overwhelmingly (13/14) hindered and your stealth is} {appraise}
	put #subs {^But considering all the armor and shields you are wearing or carrying, you are currently insanely hindered and your stealth is} {But considering 	put all the armor and shields you are wearing or carrying, you are currently insanely (14/14) hindered and your stealth is} {appraise}
	put #subs {and your stealth is unhindered\.\$} {and your stealth is unhindered (0/14).} {appraise}
	put #subs {and your stealth is barely hindered\.\$} {and your stealth is barely (1/14) hindered.} {appraise}
	put #subs {and your stealth is minimally hindered\.\$} {and your stealth is minimally (2/14) hindered.} {appraise}
	put #subs {and your stealth is insignificantly hindered\.\$} {and your stealth is insignificantly (3/14) hindered.} {appraise}
	put #subs {and your stealth is lightly hindered\.\$} {and your stealth is lightly (4/14) hindered.} {appraise}
	put #subs {and your stealth is fairly hindered\.\$} {and your stealth is fairly (5/14) hindered.} {appraise}
	put #subs {and your stealth is somewhat hindered\.\$} {and your stealth is somewhat (6/14) hindered.} {appraise}
	put #subs {and your stealth is moderately hindered\.\$} {and your stealth is moderately (7/14) hindered.} {appraise}
	put #subs {and your stealth is rather hindered\.\$} {and your stealth is rather (8/14) hindered.} {appraise}
	put #subs {and your stealth is very hindered\.\$} {and your stealth is very (9/14) hindered.} {appraise}
	put #subs {and your stealth is highly hindered\.\$} {and your stealth is highly (10/14) hindered.} {appraise}
	put #subs {and your stealth is greatly hindered\.\$} {and your stealth is greatly (11/14) hindered.} {appraise}
	put #subs {and your stealth is extremely hindered\.\$} {and your stealth is extremely (12/14) hindered.} {appraise}
	put #subs {and your stealth is overwhelmingly hindered\.\$} {and your stealth is overwhelmingly (13/14) hindered.} {appraise}
	put #subs {and your stealth is insanely hindered\.\$} {and your stealth is insanely (14/14) hindered.} {appraise}
	put #subs {(is|are) extremely weak and easily damaged,} {\$1 extremely weak and easily damaged (1/18),} {appraise}
	put #subs {(is|are) very delicate and easily damaged,} {\$1 very delicate and easily damaged (2/18),} {appraise}
	put #subs {(is|are) quite fragile and easily damaged,} {\$1 quite fragile and easily damaged (3/18),} {appraise}
	put #subs {(is|are) rather flimsy and easily damaged,} {\$1 rather flimsy and easily damaged (4/18),} {appraise}
	put #subs {(is|are) particularly weak against damage,} {\$1 particularly weak against damage (5/18),} {appraise}
	put #subs {(is|are) somewhat unsound against damage,} {\$1 somewhat unsound against damage (6/18),} {appraise}
	put #subs {(is|are) appreciably susceptible to damage,} {\$1 appreciably susceptible to damage (7/18),} {appraise}
	put #subs {(is|are) marginally vulnerable to damage,} {\$1 marginally vulnerable to damage (8/18),} {appraise}
	put #subs {(is|are) of average construction,} {\$1 of average construction (9/18),} {appraise}
	put #subs {(is|are) a bit safeguarded against damage,} {\$1 a bit safeguarded against damage (10/18),} {appraise}
	put #subs {(is|are) rather reinforced against damage,} {\$1 rather reinforced against damage (11/18),} {appraise}
	put #subs {(is|are) quite guarded against damage,} {\$1 quite guarded against damage (12/18),} {appraise}
	put #subs {(is|are) highly protected against damage,} {\$1 highly protected against damage (13/18),} {appraise}
	put #subs {(is|are) very strong against damage,} {\$1 very strong against damage (14/18),} {appraise}
	put #subs {(is|are) extremely resistant to damage,} {\$1 extremely resistant to damage (15/18),} {appraise}
	put #subs {(is|are) unusually resilient to damage,} {\$1 unusually resilient to damage (16/18),} {appraise}
	put #subs {(is|are) nearly impervious to damage,} {\$1 nearly impervious to damage (17/18),} {appraise}
	put #subs {(is|are) practically invulnerable to damage,} {\$1 practically invulnerable to damage (18/18),} {appraise}
	put #subs {, and (is|are|has|have|contains?) battered and practically destroyed\.\$} {, and \$1 battered and practically destroyed (0-19%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) badly damaged\.\$} {, and \$1 badly damaged (20-29%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) heavily scratched and notched\.\$} {, and \$1 heavily scratched and notched (30-39%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) several unsightly notches\.\$} {, and \$1 several unsightly notches (40-49%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) a few dents and dings\.\$} {, and \$1 a few dents and dings (50-59%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) some minor scratches\.\$} {, and \$1 some minor scratches (60-69%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) rather scuffed up\.\$} {, and \$1 rather scuffed up (70-79%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) in good condition\.\$} {, and \$1 in good condition (80-89%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) practically in mint condition\.\$} {, and \$1 practically in mint condition (90-98%).} {appraise}
	put #subs {, and (is|are|has|have|contains?) in pristine condition\.\$} {, and \$1 in pristine condition (99-100%).} {appraise}
Appraiseing:
	gosub Send RT "appraise %Appraise.command" "^You think you can.*$" "^You are pretty sure you can PUSH the BUTTON to start playing the spinneret game\.$" "WARNING MESSAGES"
	var Appraise.response %Send.response
	if ("%Send.success" == "1") then var Appraise.success 1
	put #subs clear
	return