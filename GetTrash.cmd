#REQUIRE Drop.cmd
#REQUIRE Get.cmd
#REQUIRE Trash.cmd


gosub GetTrash %0
exit

GetTrash:
	eval GetTrash.item tolower("$0")
	var GetTrash.success 0
	if (matchre("%GetTrash.item", "^\s*my\s+(.+)")) then var GetTrash.item $1
GetTrashing:
	gosub Get my %GetTrash.item
	if (%Get.success == 0) then return
	gosub Trash my %GetTrash.item
	if (%Trash.success == 1) then var GetTrash.success 1
	return