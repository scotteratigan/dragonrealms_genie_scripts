#REQUIRE GetDrop.cmd


gosub GetDropAll %0
exit

GetDropAll:
	eval GetDropAll.item tolower("$0")
	var GetDropAll.success 0
	if (matchre("%GetDropAll.item", "^\s*my\s+(.+)")) then var GetDropAll.item $1
GetDropAlling:
	gosub GetDrop %GetDropAll.item
	if (%GetDrop.success == 0) then return
	goto GetDropAlling