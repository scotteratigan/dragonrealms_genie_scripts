#REQUIRE Send.cmd
#REQUIRE Numerify.cmd

gosub Measure %0
exit

Measure:
	var Measure.command $0
	var Measure.success 0
	var Measure.volume 0
	var Measure.length 0
	var Measure.width 0
	var Measure.height 0
	var Measure.lengthText null
	var Measure.widthText null
	var Measure.heightText null
	action var Measure.lengthText $1 when ^You.+length measures ([\w -]+) spans?.*\.$
	action var Measure.widthText $1 when ^You.+width measures ([\w -]+) spans?.*\.$
	action var Measure.heightText $1 when ^You.+height measures ([\w -]+) spans?.*\.$
	action var Measure.volume $1 when ^The .+ appears to possess a volume of (\d+)\.$
	gosub Send RT "measure %Measure.command" "^.*(carrying capacity|possess a volume of).*$" "^What do you want to measure\?$|^You must be holding .+ to measure it\.$" "WARNING MESSAGES"
	action remove ^You.+length measures ([\w -]+) spans?.*\.$
	action remove ^You.+width measures ([\w -]+) spans?.*\.$
	action remove ^You.+length measures ([\w -]+) spans?.*\.$
	action remove ^The .+ appears to possess a volume of (\d+)\.$
	var Measure.response %Send.response
	if ("%Send.success" == "1") then var Measure.success 1

	if ("%Measure.lengthText" != "null") then {
		gosub Numerify %Measure.lengthText
		var Measure.length %Numerify.value
	}
	if ("%Measure.widthText" != "null") then {
		gosub Numerify %Measure.widthText
		var Measure.width %Numerify.value
	}
	if ("%Measure.heightText" != "null") then {
		gosub Numerify %Measure.heightText
		var Measure.height %Numerify.value
	}
	return

#You are certain that the ingot's length measures six spans, are certain that the ingot's width measures two spans and are certain that the ingot's height measures one span.
#The ingot appears to possess a volume of 153.
#Roundtime: 8 sec.

#You are certain that the pack's interior length measures fifteen spans, are certain that the pack's interior width measures ten spans and are certain that the pack's interior height measures five spans.
#You are certain that the pack's interior carrying capacity is about one thousand stones.
#Roundtime: 8 sec.