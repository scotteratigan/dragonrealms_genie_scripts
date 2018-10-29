#REQUIRE Error.cmd

# Todo: change Arrayify.string to Arrayify.list for clarity. Keep Arrayify.string for the original text input.

gosub Arrayify %0
return

Arrayify:
	eval Arrayify.string tolower("$0")
	if "%Arrayify.string" == "" then {
		gosub Error Arrayify called with no string.
		return
	}
	# Fix for treasure maps (because they have 'and' in the item name:
	eval Arrayify.string replace("%Arrayify.string", "a worn and tattered map", "a worn --- tattered map")
	# Fix for jewelry with two types of metal:
	var jewelryMetals anlora-avtoma|brass|bronze|copper|electrum|Elven silver|gold|iron|lead|palladium|pewter|platinum|red gold|silver|steel|tin|white gold|white silver
	if matchre("%Arrayify.string", "^(.*)(%jewelryMetals) and? (%jewelryMetals)(.*)$") then var Arrayify.string $1$2 - $3$4
	#echo array is %Arrayify.string
	# In rare cases, there's ', and ' instead of ' and ' between the penultimate and ultimate item.
	eval Arrayify.string replace("%Arrayify.string", ", and ", "|")
	eval Arrayify.string replace("%Arrayify.string", ", ", "|")
	eval Arrayify.string replace("%Arrayify.string", " and ", "|")
	# Remove final period, if it exists:
	eval Arrayify.string replacere("%Arrayify.string", "\.$", "")
	# Re-add the word 'and' if it was removed:
	eval Arrayify.string replace("%Arrayify.string", " --- ", " and ")
	# Setting a global #tvar here also in case this is run standalone.
	put #tvar Arrayify.string %Arrayify.string
	return