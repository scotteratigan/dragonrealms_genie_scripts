#REQUIRE Send.cmd

gosub Justice %0
exit

Justice:
	var Justice.success 0
	action var Justice.lawless 1;var Justice.type none when ^You're fairly certain this area is lawless and unsafe\.$
	action var Justice.lawless 0;var Justice.type normal when ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
	action var Justice.lawless 0;var Justice.type unusual when ^After assessing the area, you believe there is some kind of unusual law enforcement in this area\.$
	gosub Send Q "justice" "^You're fairly certain this area is lawless and unsafe\.$|^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$|^After assessing the area, you believe there is some kind of unusual law enforcement in this area\.$"
	if ("%Send.success" == "1") then var Justice.success 1
	action remove ^You're fairly certain this area is lawless and unsafe\.$
	action remove ^After assessing the area, you think local law enforcement keeps an eye on what's going on here\.$
	action remove ^After assessing the area, you believe there is some kind of unusual law enforcement in this area\.$
	return
