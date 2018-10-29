#REQUIRE Error.cmd
gosub Nounify %0
exit

Nounify:
	eval Nounify.fullItemName tolower("$0")
	if "%Nounify.fullItemName" == "" then {
		gosub Error Nounify called with no string.
		return
	}
	var Nounify.noun %Nounify.fullItemName
	put #tvar Nounify.noun null
	# Fix for deeds:
	if matchre("%Nounify.noun", "a deed for an? (\S+) \w+") then {
		# technically, this is two words, but more helpful. Might need to do this with other items as well.
		var Nounify.noun $1 deed
		goto NounifyReturn
	}
	# Random/Odd suffixes first:
	eval Nounify.noun replacere("%Nounify.noun", " (hanging from|set in|set with) .+", "")
	# With word preceeding 'with' suffix:
	eval Nounify.noun replacere("%Nounify.noun", " (decorated|embroidered|painted|sealed|trimmed) with .+", "")
	# Just the 'with' suffix:
	eval Nounify.noun replacere("%Nounify.noun", " with .+", "")
	# Suffix removed, now last word should be the noun:
	eval Nounify.noun replacere("%Nounify.noun", ".+ ", "")
NounifyReturn:
	put #tvar Nounify.noun %Nounify.noun
	return