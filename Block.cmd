#REQUIRE Send.cmd

gosub Block %0
exit

Block:
	var Block.option $0
	gosub Send RT "block %Block.option" "^Roundtime:|^You divert some of your attention to defending against .+\.$|^You stop trying to defend against .+\.$|^You aren't trying to defend against a second foe\!$" "^But you are already blocking, or did you mean to defend against a specific foe\?$|^What do you want to defend against\?$|^You are already facing .+\!$|^You are already trying to defend against .+\!$"
	return