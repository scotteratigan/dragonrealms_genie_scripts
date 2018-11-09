#REQUIRE Error.cmd
#REQUIRE Move.cmd

gosub MoveSetRoomId %0
exit

MoveSetRoomId:
	var MoveSetRoomId.arguments $0
	var MoveSetRoomId.success 0
	var MoveSetRoomId.roomId 0
	var MoveSetRoomId.movementCommand null
	if (matchre("%MoveSetRoomId.arguments", "^(\d+) (.+)")) then {
		var MoveSetRoomId.roomId $1
		var MoveSetRoomId.movementCommand $2
	}
	if (%MoveSetRoomId.roomId == 0) then {
		gosub Error MoveSetRoomId not called correctly, need to specify roomid, then movement command.
		return
	}
	gosub Move %MoveSetRoomId.movementCommand
	if (%Move.success == 1) then {
		put #mapper roomid %MoveSetRoomId.roomId
		put #var roomid %MoveSetRoomId.roomId
		var MoveSetRoomId.success 1
		pause .01
	}
	return

