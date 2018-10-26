#REQUIRE Get.cmd
#REQUIRE Wear.cmd

# Todo: modify this to accept an array as well

gosub GetWear %0
exit

GetWear:
	var GetWear.item $0
	var GetWear.success 0
GetWearing:
	gosub Get %GetWear.item
	if ("%Get.success" != "1") then return
	gosub Wear %GetWear.item
	if ("%Send.success" == "1") then var GetWear.success 1
	return