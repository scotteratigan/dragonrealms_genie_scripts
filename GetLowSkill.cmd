# Example: gosub GetLowSkill Small_Blunt|Small_Edged|Crossbow|Slings
# Example2: gosub GetLowSkill Augmentation|Utility|Warding
# Determines the lowest learning rate among a list of skills.
# Sets 2 variables: GetLowSkill.lowSkill (the name of the skill), GetLowSkill.lowRate (0-34)

gosub GetLowSkill %0
exit

GetLowSkill:
	# The replace is necessary to fix standalone running (_ is replaced with a space on input, no way to override.):
	eval GetLowSkill.list replace("$0", " ", "_")
	# Todo: define success and failure?
	#var GetLowSkill.success 0
	var GetLowSkill.index 1
	eval GetLowSkill.maxIndex count("%GetLowSkill.list", "|")
	math GetLowSkill.maxIndex add 1
	eval GetLowSkill.lowSkill element("%GetLowSkill.list", 0)
	var GetLowSkill.lowRate $%GetLowSkill.lowSkill.LearningRate
GettingLowestSkill:
	eval GetLowSkill.currentSkill element("%GetLowSkill.list", %GetLowSkill.index)
	eval GetLowSkill.currentLearningRate $%GetLowSkill.currentSkill.LearningRate
	if %GetLowSkill.currentLearningRate < %GetLowSkill.lowRate then
	{
		var GetLowSkill.lowSkill %GetLowSkill.currentSkill
		var GetLowSkill.lowRate %GetLowSkill.currentLearningRate
	}
	math GetLowSkill.index add 1
	if %GetLowSkill.index < %GetLowSkill.maxIndex then goto GettingLowestSkill
	put #tvar GetLowSkill.lowSkill %GetLowSkill.lowSkill
	#echo LowSkill: %GetLowSkill.lowSkill %GetLowSkill.lowRate/34
	return