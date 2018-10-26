#REQUIRE Drop.cmd
#REQUIRE Get.cmd

# Todo: modify this to accept an array as well.

gosub GetDrop %0
exit

GetDrop:
	var GetDrop.item $0
	var GetDrop.success 0
GetDroping:
	gosub Get my %GetDrop.item
	if (%Get.success == 0) then return
	gosub Drop %GetDrop.item
	if (%Drop.success == 1) then var GetDrop.success 1
	return