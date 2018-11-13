#REQUIRE Fish.cmd
#REQUIRE Ordinalify.cmd
#REQUIRE GetBait.cmd
#REQUIRE EnsureHands.cmd

Fishing:
	gosub EnsureHands fishing pole:Empty
	random 1 5
	gosub Ordinalify %r
	gosub GetBait %Ordinalify.ordinal white box
	gosub Fish
	goto Fishing