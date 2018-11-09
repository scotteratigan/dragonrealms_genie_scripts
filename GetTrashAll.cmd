#REQUIRE GetTrash.cmd


gosub GetTrashAll %0
exit

GetTrashAll:
	eval GetTrashAll.item tolower("$0")
	var GetTrashAll.success 0
	if (matchre("%GetTrashAll.item", "^\s*my\s+(.+)")) then var GetTrashAll.item $1
GetTrashAlling:
	gosub GetTrash %GetTrashAll.item
	if (%GetTrash.success == 0) then return
	goto GetTrashAlling