#REQUIRE Arrayify.cmd
#REQUIRE Error.cmd
#REQUIRE Inventory.cmd
#REQUIRE Sort.cmd

# Used to combine cloths of different thicknesses but of same type.
# Suggested usage:
# 1. Deed all cloth
# 2. Undeed all cloth of specific type (like ruazen), and store in large container or vault.
# 3. Run this script to combine everything
# 4. Redeed, and repeat with a different cloth type.

gosub CombineCloth %0
exit

CombineCloth:
	var CombineCloth.container $0
	if ("%CombineCloth.container" == "") then {
		gosub Error You must specify a container to combine cloth in.
		return
	}
	gosub Sort cloth in %CombineCloth.container
	if (%Sort.success != 1) then {
		gosub Error Unable to sort cloth in %CombineCloth.container, aborting.
		return
	}
CombiningCloth:
	gosub Inventory %CombineCloth.container
	gosub Arrayify %Inventory.list
	var currentThickness %Arrayify.
	eval currentThickness element("%Inventory.")