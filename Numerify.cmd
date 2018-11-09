gosub Numerify %0
exit

# Should work for numbers up to 9999
# Lots of opportunities to make this more efficient/recursive, etc.

Numerify:
	var Numerify.input $0
	var Numerify.value 0
	# Thousands
	if (contains("%Numerify.input", "one thousand")) then math Numerify.value add 1000
	if (contains("%Numerify.input", "two thousand")) then math Numerify.value add 2000
	if (contains("%Numerify.input", "three thousand")) then math Numerify.value add 3000
	if (contains("%Numerify.input", "four thousand")) then math Numerify.value add 4000
	if (contains("%Numerify.input", "five thousand")) then math Numerify.value add 5000
	if (contains("%Numerify.input", "six thousand")) then math Numerify.value add 6000
	if (contains("%Numerify.input", "seven thousand")) then math Numerify.value add 7000
	if (contains("%Numerify.input", "eight thousand")) then math Numerify.value add 8000
	if (contains("%Numerify.input", "nine thousand")) then math Numerify.value add 9000
	# Hundreds
	if (contains("%Numerify.input", "one hundred")) then math Numerify.value add 100
	if (contains("%Numerify.input", "two hundred")) then math Numerify.value add 200
	if (contains("%Numerify.input", "three hundred")) then math Numerify.value add 300
	if (contains("%Numerify.input", "four hundred")) then math Numerify.value add 400
	if (contains("%Numerify.input", "five hundred")) then math Numerify.value add 500
	if (contains("%Numerify.input", "six hundred")) then math Numerify.value add 600
	if (contains("%Numerify.input", "seven hundred")) then math Numerify.value add 700
	if (contains("%Numerify.input", "eight hundred")) then math Numerify.value add 800
	if (contains("%Numerify.input", "nine hundred")) then math Numerify.value add 900
	# Tens
	if (contains("%Numerify.input", "twenty")) then math Numerify.value add 20
	if (contains("%Numerify.input", "thirty")) then math Numerify.value add 30
	if (contains("%Numerify.input", "fourty")) then math Numerify.value add 40
	if (contains("%Numerify.input", "fifty")) then math Numerify.value add 50
	if (contains("%Numerify.input", "sixty")) then math Numerify.value add 60
	if (contains("%Numerify.input", "seventy")) then math Numerify.value add 70
	if (contains("%Numerify.input", "eighty")) then math Numerify.value add 80
	if (contains("%Numerify.input", "ninety")) then math Numerify.value add 90
	# Teens
	if (contains("%Numerify.input", "nineteen")) then math Numerify.value add 19
	if (contains("%Numerify.input", "eighteen")) then math Numerify.value add 18
	if (contains("%Numerify.input", "seventeen")) then math Numerify.value add 17
	if (contains("%Numerify.input", "sixteen")) then math Numerify.value add 16
	if (contains("%Numerify.input", "fifteen")) then math Numerify.value add 15
	if (contains("%Numerify.input", "fourteen")) then math Numerify.value add 14
	if (contains("%Numerify.input", "thirteen")) then math Numerify.value add 13
	if (contains("%Numerify.input", "twelve")) then math Numerify.value add 12
	if (contains("%Numerify.input", "eleven")) then math Numerify.value add 11
	if (contains("%Numerify.input", "ten")) then math Numerify.value add 10
	# Ones
	if (matchre("%Numerify.input", "nine$")) then math Numerify.value add 9
	if (matchre("%Numerify.input", "eighth$")) then math Numerify.value add 8
	if (matchre("%Numerify.input", "seven$")) then math Numerify.value add 7
	if (matchre("%Numerify.input", "six$")) then math Numerify.value add 6
	if (matchre("%Numerify.input", "five$")) then math Numerify.value add 5
	if (matchre("%Numerify.input", "four$")) then math Numerify.value add 4
	if (matchre("%Numerify.input", "three$")) then math Numerify.value add 3
	if (matchre("%Numerify.input", "two$")) then math Numerify.value add 2
	if (matchre("%Numerify.input", "one$")) then math Numerify.value add 1
	echo Numerify.value: %Numerify.value
	return