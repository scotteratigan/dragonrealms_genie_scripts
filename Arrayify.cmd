#REQUIRE Error.cmd

# Arrayify.string <- the text input (a copper coin, a bronze coin, and a gold coin)
# Arrayify.list <- the resulting list (a copper coin|a bronze coin|a gold coin)
# Arrayify.maxIndex <- the last element you can reference by index (length + 1)

gosub Arrayify %0
return

Arrayify:
	eval Arrayify.string tolower("$0")
	if "%Arrayify.string" == "" then {
		gosub Error Arrayify called with no text.
		return
	}
	# Fix for treasure maps (because they have 'and' in the item name:
	eval Arrayify.list replace("%Arrayify.string", "a worn and tattered map", "a worn --- tattered map")
	# Fix for jewelry with two types of metal:
	var jewelryMetals anlora-avtoma|brass|bronze|copper|electrum|Elven silver|gold|iron|lead|palladium|pewter|platinum|red gold|silver|steel|tin|white gold|white silver
	if matchre("%Arrayify.list", "^(.*)(%jewelryMetals) and? (%jewelryMetals)(.*)$") then var Arrayify.list $1$2 - $3$4
	#echo array is %Arrayify.list
	# In rare cases, there's ', and ' instead of ' and ' between the penultimate and ultimate item.
	eval Arrayify.list replace("%Arrayify.list", ", and ", "|")
	eval Arrayify.list replace("%Arrayify.list", ", ", "|")
	eval Arrayify.list replace("%Arrayify.list", " and ", "|")
	# Remove final period, if it exists:
	eval Arrayify.list replacere("%Arrayify.list", "\.$", "")
	# Re-add the word 'and' if it was removed:
	eval Arrayify.list replace("%Arrayify.list", " --- ", " and ")
	eval Arrayify.maxIndex count("%Arrayify.list", "|")
	return