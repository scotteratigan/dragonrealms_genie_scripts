#REQUIRE Send.cmd

gosub Task %0
exit

Task:
	var Task.success 0
	var Task.tallies null
	action var Task.tallies $1 when ^(\d+ .+ tasks.*)$
	action var Task.inProgress 1 when ^You look in your task journal and see the following entry:$
	action var Task.inProgress 0 when ^You are not currently on a task\.$
Tasking:
	gosub Send Q "task" "^You are not currently on a task\.$|^You look in your task journal and see the following entry:$" "FAIL MESSAGES" "WARNING MESSAGES"
	pause .01
	action remove ^(\d+ .+ tasks.*)$
	action remove ^You look in your task journal and see the following entry:$
	action remove ^You are not currently on a task\.$
	var Task.response %Send.response
	if ("%Send.success" == "1") then {
		var Task.success 1
		return
	}
	return