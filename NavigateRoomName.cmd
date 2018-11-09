#REQUIRE Error.cmd
#REQUIRE Navigate.cmd

# Examples:
# gosub NavigateRoomName 210 rats The Massive Arachnid, Haemolymphatic Prechamber
# .NavigateRoomName 210 rats The Massive Arachnid, Haemolymphatic Prechamber

# Note: this format was chosen because then input can be the same for command line or gosub.
# You cannot strip out quotes from a string in Genie without complicated workarounds like parse/action triggers or javascript calls.
# See also: NavigateRoomDescription.cmd

gosub NavigateRoomName %0
exit

NavigateRoomName:
	var NavigateRoomName.zone $1
	var NavigateRoomName.destination $2
	eval NavigateRoomName.roomName replacere("$0", "($1 |$2 )", "")
	echo NavigateRoomName.roomName is %NavigateRoomName.roomName
	var NavigateRoomName.success 0
	if ("$roomname" == "%NavigateRoomName.roomName") then {
		var NavigateRoomName.success 1
		return
	}
	gosub Navigate %NavigateRoomName.zone "%NavigateRoomName.destination"
	if ("%Navigate.success" == "1") then {
		var NavigateRoomName.success 1
		return
	}
	gosub Error Navigation was unsuccessful.
	return