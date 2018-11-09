#REQUIRE Error.cmd
#REQUIRE Navigate.cmd

# Examples:
# gosub NavigateRoomDescription 210 rats Constant 'drip, drip, drip' sounds echo through the cramped area, which is narrower than it is tall.
# .NavigateRoomDescription 210 rats Constant 'drip, drip, drip' sounds echo through the cramped area, which is narrower than it is tall.
# Important: You don't need the entire room description, but you must use some of the beginning of it.
# Avoid any quotes (") in room descriptions!

# Note: this format was chosen because then input can be the same for command line or gosub.
# You cannot strip out quotes from a string in Genie without complicated workarounds like parse/action triggers or javascript calls.
# See also: NavigateRoomName.cmd

gosub NavigateRoomDescription %0
exit

NavigateRoomDescription:
	var NavigateRoomDescription.zone $1
	var NavigateRoomDescription.destination $2
	eval NavigateRoomDescription.roomName replacere("$0", "($1 |$2 )", "")
	echo NavigateRoomDescription.roomName is %NavigateRoomDescription.roomName
	var NavigateRoomDescription.success 0
	if (matchre("$roomdesc" "^%NavigateRoomDescription.roomName")) then {
		var NavigateRoomDescription.success 1
		return
	}
	gosub Navigate %NavigateRoomDescription.zone "%NavigateRoomDescription.destination"
	if ("%Navigate.success" == "1") then {
		var NavigateRoomDescription.success 1
		return
	}
	gosub Error Navigation was unsuccessful.
	return