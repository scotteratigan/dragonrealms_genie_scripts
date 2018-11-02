#REQUIRE Drop.cmd
#REQUIRE Get.cmd
#REQUIRE Trash.cmd


gosub GetTrash %0
exit

GetTrash:
	var GetTrash.item $0
	var GetTrash.success 0
GetTrashing:
	gosub Get my %GetTrash.item
	if (%Get.success == 0) then return
	gosub Trash %GetTrash.item
	if (%Trash.success == 1) then var GetTrash.success 1
	return