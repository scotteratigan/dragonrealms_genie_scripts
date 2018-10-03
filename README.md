# dragonrealms_genie_scripts
To automate increasingly complex tasks in the MUD DragonRealms using the Genie front end and custom compiler.

The basic premise is that each action verb in the game will be it's own script.
More complex scripts will combine code from simple action scripts.
Every script should be able to run standalone, or as an include inside of a larger script that allows gosubbing.
This allows the same code to be run from the command line, within scripts, and from triggers.

Why not just run each script individually?
It is not feasible to run each script one-after-another without performance issues due to compile-at-runtime as well as file access issues which result in the "Unable to acquire writer lock." error. So it is important to allow execution both ways.

Are there downsides to this approach?
Because the scripts will have multiple-levels of includes, many files are included more than once. However, Genie does not have a preprocessor directive that allows code to be included only if it isn't already included, so this script library relies on a custom plugin written by DR_Saet which implements a new include syntax called #REQUIRE scriptname. This assumes that your source scripts are stored in the /Scripts/source directory, and 'assembles' them in the main /Scripts/ directory.
