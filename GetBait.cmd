#REQUIRE Get.cmd
#REQUIRE Look.cmd

gosub GetBait %0
exit

GetBait:
	var GetBait.location $0
	var GetBait.success 0
	#debuglevel 5
	gosub Look in %GetBait.location
	if ("%Look.contents" == "a large glob of fish eggs") then var GetBait.noun fish eggs
	if ("%Look.contents" == "a hunk of old meat") then var GetBait.noun old meat
	if ("%Look.contents" == "some live minnows") then var GetBait.noun live minnows
	if ("%Look.contents" == "some small live fish") then var GetBait.noun live fish
	if ("%Look.contents" == "some handmade worms") then var GetBait.noun handmade worms
GettingBait:
	gosub Get %GetBait.noun from %GetBait.location
	if (%Get.success != 1) then goto GettingBait
	var GetBait.success 1
	return
		