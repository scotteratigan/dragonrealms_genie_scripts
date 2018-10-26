# dragonrealms_genie_scripts
To automate increasingly complex tasks in the MUD DragonRealms using the Genie front end and custom compiler.
All scripts are written in Genie Scripting Language (.cmd files).
Genie scripting language is an extension of the original Wizard Scripting Language.
This project aims to extend the Genie Scripting Language further with a compilation step.

The basic premise is that each action verb in the game will be it's own script.
More complex scripts will combine code from simple action scripts.
Every script should be able to run standalone, or as an include inside of a larger script that allows gosubbing.
This allows the same code to be run from the command line, within scripts, and from triggers.

Why not just run each script individually?
It is not feasible to run each script one-after-another without performance issues due to compile-at-runtime as well as file access issues which result in the "Unable to acquire writer lock." error. However, for flexibility with global triggers or the command prompt, there is value in allowing scripts to be run independently as well as included.

Are there downsides to this approach?
Because the scripts will have multiple-levels of includes, many files are included more than once. However, Genie does not have a preprocessor directive that allows code to be included only as needed, so this script library relies on a custom plugin written by DR_Saet which implements a new include syntax called #REQUIRE scriptname. This assumes that your source scripts are stored in the /Scripts/source directory, and 'assembles' them in the main /Scripts/ directory. Every time you make a change to a script, it needs to be recompiled before use. If you make a change to a script that is included in many other scripts (send.cmd for instance), it is recommended that you '/compile all' in order to update all scripts.

Why are almost all variables local if the idea is a global inter-connected scripting approach?
Global variables are an order of magnitude slower than local variables at runtime, due to the fact that they can trigger actions. In this project, global variables will be used mostly to store preferences rather than runtime values.

Future plans include benchmarking in terms of:
	-runtime speed, compared to traditional approaches
	-new script development time
