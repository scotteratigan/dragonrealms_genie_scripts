# todo: add command line hack for .ATTACK chop goblin
# todo: break out attacks into own scripts, rename this DO_ATTACK?
#REQUIRE Advance.cmd
#REQUIRE Send.cmd
gosub ATTACK %0
exit

ATTACK:
	# todo: add guild-only attacks barbarian, paladin?
	# Default/regular attack:
		var ATTACK.option $0
		var ATTACK.verb attack
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	BASH:
		var ATTACK.option $0
		var ATTACK.verb bash
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	BITE:
		var ATTACK.option $0
		var ATTACK.verb bite
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 1
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	BLINDSIDE:
		var ATTACK.option $0
		var ATTACK.verb blindside
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 1
		goto ATTACKING
	BOB:
		var ATTACK.option $0
		var ATTACK.verb bob
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	BUTT:
		var ATTACK.option $0
		var ATTACK.verb butt
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 1
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	CHOP:
		var ATTACK.option $0
		var ATTACK.verb chop
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	CIRCLE:
		var ATTACK.option $0
		var ATTACK.verb circle
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 0
		var ATTACK.requiresStealth 0
		goto ATTACKING
	CLAW:
		var ATTACK.option $0
		var ATTACK.verb claw
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	DRAW:
		var ATTACK.option $0
		var ATTACK.verb draw
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	ELBOW:
		var ATTACK.option $0
		var ATTACK.verb elbow
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	FEINT:
		var ATTACK.option $0
		var ATTACK.verb feint
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	GOUGE:
		var ATTACK.option $0
		var ATTACK.verb gouge
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	GRAPPLE:
		var ATTACK.option $0
		var ATTACK.verb grapple
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 0
		var ATTACK.requiresStealth 0
		goto ATTACKING
	JAB:
		var ATTACK.option $0
		var ATTACK.verb jab
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	KICK:
		var ATTACK.option $0
		var ATTACK.verb kick
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	KNEE:
		var ATTACK.option $0
		var ATTACK.verb knee
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 1
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
	LUNGE:
		var ATTACK.option $0
		var ATTACK.verb lunge
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	POACH:
		var ATTACK.option $0
		var ATTACK.verb poach
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 1
		goto ATTACKING
	PUMMEL:
		var ATTACK.option $0
		var ATTACK.verb pummel
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	PUNCH:
		var ATTACK.option $0
		var ATTACK.verb punch
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SHOVE:
		# Note: a successful shove breaks the grapple effect.
		var ATTACK.option $0
		var ATTACK.verb shove
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 0
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SLAM:
		var ATTACK.option $0
		var ATTACK.verb slam
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SLAP:
		var ATTACK.option $0
		var ATTACK.verb slap
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SLICE:
		var ATTACK.option $0
		var ATTACK.verb slice
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SNIPE:
		var ATTACK.option $0
		var ATTACK.verb snipe
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 1
		goto ATTACKING
	SWEEP:
		var ATTACK.option $0
		var ATTACK.verb sweep
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	SWING:
		var ATTACK.option $0
		var ATTACK.verb swing
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		goto ATTACKING
	TACKLE:
		# Note: a successful tackle will create a grapple effect.
		var ATTACK.option $0
		var ATTACK.verb tackle
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 0
		var ATTACK.requiresStealth 0
		goto ATTACKING
	THRUST:
		var ATTACK.option $0
		var ATTACK.verb thrust
		var ATTACK.requiresWeapon 1
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 1
		var ATTACK.requiresStealth 0
		goto ATTACKING
	WEAVE:
		var ATTACK.option $0
		var ATTACK.verb weave
		var ATTACK.requiresWeapon 0
		var ATTACK.requiresGrapple 0
		var ATTACK.isDamaging 0
		var ATTACK.requiresStealth 0
		goto ATTACKING
