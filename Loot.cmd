#REQUIRE Arrayify.cmd
#REQUIRE Send.cmd

gosub Loot %0
exit

Loot:
	var Loot.option $0
	var Loot.equipment null
	var Loot.lodgedItems null
	var Loot.mobName null
	var Loot.mobNoun null
	var Loot.treasure null
	var Loot.treasureList
	action var Loot.mobName $1 when ^You search the (.+)\.$
	action var Loot.mobNoun $1 when ^You search.+ (\S+)\.$
	action var Loot.treasure $1;echo Treasure: $1 when ^The .+ was carrying (.+).$
	action var Loot.equipment %Loot.treasure;echo Loot.equipment should be %Loot.treasure;var Loot.treasure $1 when ^You also find (.+)\!$
	action var Loot.lodgedItems $1 when ^Lodged into it was (.+)\.$
	gosub Send W "Loot %Loot.option" "^You search .+\.$" "^You should probably wait until .+ is dead first\.$|^The .+ has already been searched for that\$!"
	put #echo >Log white Looted: %Loot.mobName and found %Loot.treasure
	#echo Looted: %Loot.mobName (%Loot.mobNoun)
	#echo Equipment: %Loot.equipment
	#echo Treasure: %Loot.treasure
	action remove ^You search the (.+)\.$
	action remove ^You search.+ (\S+)\.$
	action remove ^The .+ was carrying (.+)\!$
	action remove ^You also find (.+)\!$
	action remove ^Lodged into it was (.+)\.$
	if ("%Loot.treasure" != "null") then {
		gosub Arrayify %Loot.treasure
		var Loot.treasureList %Arrayify.string
		put #tvar Loot.treasureList %Arrayify.string
	}
	if ("%Loot.lodgedItems" != "null") then {
		gosub Arrayify %Loot.lodgedItems
		var Loot.lodgedItemsList %Arrayify.string
		put #tvar Loot.lodgedItemsList %Arrayify.string
	}
	put #tvar Loot.treasure %Loot.treasure
	put #tvar Loot.lodgedItems %Loot.lodgedItems
	return