#REQUIRE Send.cmd

gosub Store %0
exit

# Todo: add string/trigger for store option clear and store custom?

# To use the STORE verb, you can:
# -STORE [option] in [container] - Chooses a container to store a specific kind of items in.
# -STORE [option] - List the location that you are storing a specific kind of options in.
# -STORE [option] CLEAR - Clears the container that you have set.
# -STORE CUSTOM [phrase] in [container] - Sets a container to store items with the specified phrase in  (32 characters max).
# Valid options are:
# AMMO - Ammunition.
# ARMOR - All kinds of armor, excluding shields
# GEMS - Gems and bars.
# HERBS - Herbs and Remedies
# INSTRUMENT - Instruments
# LOCKPICK - Lockpicks
# MELEE - Melee weapons.
# RANGED - Ranged weapons.
# BOXES - Treasure chests from creatures.
# SHIELD - Shields
# SKINS - Anything that you skin off of a critter (bones, skin and parts)
# THROWN - Thrown weapons.
# DEFAULT - All other items.
# Example:  STORE GEMS IN BACKPACK will put all gems in your backpack.
# Example:  STORE CUSTOM TINCT IN APRON will store any items that have a TAP that contains "TINCT" in your apron.

Store:
	var Store.option $0
	var Store.success 0
	action var Store.$1 $2 when ^\s*(ammunition|armor|gems|herbs|instruments|lockpicks|melee weapons|ranged weapons|shields|skins|thrown weapons|boxes|Default):  (.+)$
Storing:
	gosub Send Q "store %Store.option" "^\s*Default: .*$|^You will now store.+$|^You will now use your .+ to store any items you haven't categorized\.$" "^To use the STORE verb, you need to STORE \[OPTION\] IN \[CONTAINER\]\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Store.success 1
	action remove ^\s*(ammunition|armor|gems|herbs|instruments|lockpicks|melee weapons|ranged weapons|shields|skins|thrown weapons|boxes):  (.+)$
	return