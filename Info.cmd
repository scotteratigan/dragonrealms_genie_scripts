#REQUIRE Send.cmd

gosub Info %0
exit

# Todo: test all base/current stats right after death to ensure we're not making an improper assumptions on spacing, etc.

# Note: for efficiency, only call the info you need to grab
# info /stats................Show your stats
# info /concentration........Show your concentration level
# info /favors...............Show how many favors you have
# info /wealth...............Show how much wealth you have
# info /debt.................Show how much debt you have

# Sets the following variables (all variables begin with Info.blah so Info.gender for example)
# gender - male or female
# age - 15-999?
# circle - 0-200
# birthday - the 7th day of the 5th month of Uthmor the Giant in the year of the Bronze Wyvern, 365 years after the victory of Lanival the Redeemer
# favors - 5
# tdps - 318
# encumbranceText - None, Light Burden, etc
# encumbranceLevel - 0 to 11
# luck - average, etc # todo: get other values
# pirpPoints - 5 (if you're in the pirp program)
# baseStrength - 40
# currentStrength - 41 (if you're under the effect of a stat modifier, + or -)
# ...and so on for all stats (Agility, Discipline, Intelligence, Reflex, Charisma, Wisdom, Stamina)
# baseConcentration & currentConcentration - 300
# nameAndTitle - Trader King Fynmenger Ultyvalger, Table Trader of Elanthia
# lastName Ultyvalger (if it exists)
# preTitle Trader King (if it exists) todo: test if no pretitle
# postTitle Table Trader of Elanthia (if it exists) todo: test if no post title
# race - Human|Elf|Dwarf|Elothean|Gor'Tog|Halfling|S'kra Mur|Rakash|Prydaen|Gnome|Kaldar
# guild - Barbarian|Bard|Cleric|Empath|Moon Mage|Necromancer|None|Paladin|Ranger|Thief|Trader|Warrior Mage
# kronars/lirums/dokoras 12345 (total value of coins in copper, by currency)
# debtZoluren 5000 (total debt by province, in copper - note: of that province's currency)  Zoluren|Therengia|Ilithi|Qi|Forfedhdar

Info:
	var Info.option $0
	var Info.success 0
	var Info.nameAndTitle 
	action var Info.gender $1;var Info.age $2;var Info.circle $3 when ^Gender: (\w+)\s+Age: (\d+)\s+Circle: (\d+)$
	action var Info.birthday $1 when ^You were born on (.+)\.$
	action var Info.favors $1 when ^\s*Favors : (\d+)$
	action var Info.tdps $1 when ^\s*TDPs : (\d+)$
	action var Info.encumbranceText $1 when ^\s*Encumbrance : (.*)$
	action var Info.luck $1 when ^\s*Luck : (.*)$
	action var Info.pirpPoints $1 when ^\s+PIRP Points : (\d+)$
	# Info triggers are complex because stats can be under active bonus or penalty. The triggers below are 2 part. First, it identifies the stat being displayed, then sets the base and current value.
	# Set the left column stat (2 triggers - depends on if the stat is modified or not)
	action var Info.leftStat $1;var Info.base%Info.leftStat $2;var Info.current%Info.leftStat $2 when ^\s+(Strength|Agility|Discipline|Intelligence) :\s+(\d+)\s+(Reflex|Charisma|Wisdom|Stamina)
	action var Info.leftStat $1;var Info.base%Info.leftStat $2;evalmath Info.current%Info.leftStat $2 $3 $4 when ^\s+(Strength|Agility|Discipline|Intelligence) :\s+(\d+) (\+|-)(\d+)\s+(Reflex|Charisma|Wisdom|Stamina)
	# Now set the right column stat (again 2 triggers, modified or not)
	action var Info.rightStat $2;var Info.base%Info.rightStat $3;var Info.current%Info.rightStat $3 when ^\s+(Strength|Agility|Discipline|Intelligence).+(Reflex|Charisma|Wisdom|Stamina) :\s+(\d+)\s*$
	action var Info.rightStat $2;var Info.base%Info.rightStat $3;evalmath Info.current%Info.rightStat $3 $4 $5 when ^\s+(Strength|Agility|Discipline|Intelligence).+(Reflex|Charisma|Wisdom|Stamina) :\s+(\d+) (\+|-)(\d+)\s*$
	action var Info.currentConcentration $1;var Info.baseConcentration $3 when ^Concentration : (\d+)(\s|\+|-)+Max : (\d+)\s*$
	action var Info.nameAndTitle $1;var Info.race $2;var Info.guild $3 when ^Name: (.+)\s+Race: (.+)\s+Guild: (Barbarian|Bard|Cleric|Empath|Moon Mage|Necromancer|None|Paladin|Ranger|Thief|Trader|Warrior Mage)$
	action eval Info.currency tolower($1);var Info.%Info.currency 0 when ^\s+No (Kronars|Lirums|Dokoras)\.$
	action eval Info.currency tolower($2s);var Info.%Info.currency $1 when ^\s+\d+.*\((\d+) copper (Kronar|Lirum|Dokora)s?\)\.$
	action var Info.debtZoluren 0;var Info.debtTherengia 0;var Info.debtIlithi 0;var Info.debtQi 0;var Info.debtForfedhdar 0 when ^Debt:
	action var Info.debtProvince $1;var Info.debt%Info.debtProvince $2 when ^  You owe .+ (\S+)\. \((\d+) copper (Kronars|Lirums|Dokoras)\)$
Infoing:
	gosub Send RT "info %Info.option" "^ Intelligence|^Concentration|^       Favors|^Wealth|^Debt" "^.* is an invalid option\.$" "WARNING MESSAGES"
	pause .01
	if ("%Send.success" == "1") then var Info.success 1
	action remove ^Gender: (\w+)\s+Age: (\d+)\s+Circle: (\d+)$
	action remove ^You were born on (.+)\.$
	action remove ^\s*Favors : (\d+)$
	action remove ^\s*TDPs : (\d+)$
	action remove ^\s*Encumbrance : (.*)$
	action remove ^\s*Luck : (.*)$
	action remove ^\s+PIRP Points : (\d+)$
	action remove ^\s+(Strength|Agility|Discipline|Intelligence) :\s+(\d+)\s+(Reflex|Charisma|Wisdom|Stamina)
	action remove ^\s+(Strength|Agility|Discipline|Intelligence) :\s+(\d+) (\+|-)(\d+)\s+(Reflex|Charisma|Wisdom|Stamina)
	action remove ^\s+(Strength|Agility|Discipline|Intelligence).+(Reflex|Charisma|Wisdom|Stamina) :\s+(\d+)\s*$
	action remove ^\s+(Strength|Agility|Discipline|Intelligence).+(Reflex|Charisma|Wisdom|Stamina) :\s+(\d+) (\+|-)(\d+)\s*$
	action remove ^Concentration : (\d+)(\s|\+|-)+Max : (\d+)\s*$
	action remove ^Name: (.+)\s+Race: (.+)\s+Guild: (Barbarian|Bard|Cleric|Empath|Moon Mage|Necromancer|None|Paladin|Ranger|Thief|Trader|Warrior Mage)$
	action remove ^\s+No (Kronars|Lirums|Dokoras)\.$
	action remove ^\s+\d+.*\((\d+) copper (Kronar|Lirum|Dokora)s?\)\.$
	action remove ^Debt:
	action remove ^  You owe .+ (\S+)\. \((\d+) copper (Kronars|Lirums|Dokoras)\)$
	if (!contains("%Info.nameAndTitle", "%")) then {
		# Assumes that there are no commas in a title...
		eval Info.lastName replacere("%Info.nameAndTitle", ", .+", "")
		eval Info.lastName replacere("%Info.lastName", ".+ ", "")
		if ("%Info.lastName" == "$charactername") then var Info.lastName 
		echo lastName: %Info.lastName
		eval Info.preTitle replacere("%Info.nameAndTitle", " \w+, .+", "")
		eval Info.postTitle replacere("%Info.nameAndTitle", ".+, ", "")
		echo preTitle: %Info.preTitle
		echo postTitle: %Info.postTitle
		if ("%Info.encumbranceText" == "None") then {
			var Info.encumbranceLevel 0
			return
		}
		if ("%Info.encumbranceText" == "Light Burden") then {
			var Info.encumbranceLevel 1
			return
		}
		if ("%Info.encumbranceText" == "Somewhat Burdened") then {
			var Info.encumbranceLevel 2
			return
		}
		if ("%Info.encumbranceText" == "Burdened") then {
			var Info.encumbranceLevel 3
			return
		}
		if ("%Info.encumbranceText" == "Heavy Burden") then {
			var Info.encumbranceLevel 4
			return
		}
		if ("%Info.encumbranceText" == "Very Heavy Burden") then {
			var Info.encumbranceLevel 5
			return
		}
		if ("%Info.encumbranceText" == "Overburdened") then {
			var Info.encumbranceLevel 6
			return
		}
		if ("%Info.encumbranceText" == "Very Overburdened") then {
			var Info.encumbranceLevel 7
			return
		}
		if ("%Info.encumbranceText" == "Extremely Overburdened") then {
			var Info.encumbranceLevel 8
			return
		}
		if ("%Info.encumbranceText" == "Tottering Under Burden") then {
			var Info.encumbranceLevel 9
			return
		}
		if ("%Info.encumbranceText" == "Are you even able to move?") then {
			var Info.encumbranceLevel 10
			return
		}
		if ("%Info.encumbranceText" == "It's amazing you aren't squashed!") then {
			var Info.encumbranceLevel 11
			return
		}
	}
	return

# You are carrying more than 490 items!  Please reduce your inventory count IMMEDIATELY!
# You are carrying more than 400 items on your person!  Please reduce your inventory count below this number.