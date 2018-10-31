#REQUIRE Send.cmd

gosub Release %0
exit

# Todo: add more spells as needed.
# You need the text of each spell, as there is no message unique to releasing all spells.
# Alternately, you could send a second command, like encumbrance or mindstate. I prefer this method because it is cleaner at runtime.

#EOTB: Eyes of the Blind
#GAF: Gauge Flow
#LGV: Last Gift of Vithwok IV
#LW: Lay Ward
#MAF: Manifest Force
#MEG: Membrach's Greed
#PHK: Platinum Hands of Kertigen
#RF: Refractive Field
#TURI: Turmar Illumination
#USOL: Universal Solvent

Release:
	var Release.option $0
	var Release.success 0
	var Release.textEOTB ^Your corruption fades, revealing you to the world once more\.$
	var Release.textFinesse ^You feel bereft of grace and charm as your enhanced situational awareness dissipates\.$
	var Release.textGAF ^Your eyes briefly darken\.  When you regain sight, the graphs and sigils previously impressed upon your vision have disappeared\.$
	var Release.textLGV ^A momentary mistrust of shields comes over you\.$
	var Release.textLW ^You sense your invisible ward give away, leaving you more vulnerable\.$
	var Release.textMAF ^The air around you shimmers with a weak yellow light that quickly disperses\.$
	var Release.textMEG ^Your enhanced capacity for collecting valuable resources slowly seeps away\.$
	var Release.textNonchalance ^You feel slightly on edge as the comforting sense of nepenthean detachment slips from your mind\.$
	var Release.textNoumena ^The Noumena spell wanes and the perceptual world reasserts itself before your psyche\.$
	var Release.textPHK ^Your hands feel less steady\.$
	var Release.textRF ^The refractive field surrounding you fades away\.$
	var Release.textTURI ^You feel less clear-headed and alert\.$
	var Release.textUSOL ^The greenish hues about you vanish as the Universal Solvent matrix loses its cohesion\.$
	var Release.allSpellsText %Release.textEOTB|%Release.textFinesse|%Release.textGAF|%Release.textLGV|%Release.textLW|%Release.textMAF|%Release.textMEG|%Release.textNonchalance|%Release.textNoumena|%Release.textPHK|%Release.textRF|%Release.textTURI|%Release.textUSOL
Releasing:
	gosub Send Q "release %Release.option" "^You aren't harnessing any mana\.$|^You release all the streams you were concentrating on keeping localized around you\.$|^You deftly release .+ streams? of energy, leaving .+ localized around you.$|^You don't have more than that many streams harnessed in the first place, so you simply release all of them\.$|%Release.allSpellsText|^You aren't preparing a spell\.$|^You let your concentration lapse and feel the spell's energies dissipate\.$|^You release your connection with .*\.$|^You release the Chaos symbiosis\.$" "^Release what\?$" "^You have no cyclic spell active to release\.$|^Are you sure you'd like to forget the .+ spell\?  Re\-enter this command again in 30 seconds if you're sure\.$|^You purge your mind of the .+ spell\.$"
	# Need to enter command twice if releasing an invoked spell scroll:
	if (matchre("%Send.response", "^Are you sure you'd like to forget the .+ spell\?  Re\-enter this command again in 30 seconds if you're sure\.$")) then goto Releasing
	if ("%Send.success" == "1") then var Release.success 1
	return

# Release:
#^You aren't harnessing any mana\.$|^You release all the streams you were concentrating on keeping localized around you\.$
#^You aren't preparing a spell\.$|^You let your concentration lapse and feel the spell's energies dissipate\.$
#^You have no cyclic spell active to release\.$|(Various cyclic release messages.)
