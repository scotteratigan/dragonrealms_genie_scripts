#REQUIRE Error.cmd

gosub Ordinalify %0
exit

Ordinalify:
	var Ordinalify.input $0
	var Ordinalify.success 0
	var Ordinalify.ordinal null
	if (!matchre("%Ordinalify.input", "^\d+$")) then {
		gosub Error Can't create an ordinal from input %Ordinalify.input
		return
	}
	if (%Ordinalify.input < 1) then {
		gosub Error Ordinal input must be 1 or greater.
		return
	}
	if (%Ordinalify.input > 11) then {
		gosub Error Ordinal input must be 11 or less (core game engine restriction).
		return
	}
	var Ordinalify.1 first
	var Ordinalify.2 second
	var Ordinalify.3 third
	var Ordinalify.4 fourth
	var Ordinalify.5 fifth
	var Ordinalify.6 sixth
	var Ordinalify.7 seventh
	var Ordinalify.8 eighth
	var Ordinalify.9 ninth
	var Ordinalify.10 tenth
	var Ordinalify.11 eleventh
	var Ordinalify.ordinal %Ordinalify.%Ordinalify.input
	echo Ordinalify.ordinal is %Ordinalify.ordinal
	return