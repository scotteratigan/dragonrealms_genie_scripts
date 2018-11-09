# dragonrealms_genie_scripts

# Purpose
  To automate increasingly complex tasks in the MUD DragonRealms using the Genie front end and custom compiler.
  All scripts are written in Genie Scripting Language (.cmd files).
  Genie scripting language is an extension of the original Wizard Scripting Language.
  This project aims to extend the Genie Scripting Language further with a compilation step.

The basic premise is that each action verb in the game will be it's own script.
More complex scripts will combine code from simple action scripts.
Every script should be able to run standalone, or as an include inside of a larger script that allows gosubbing.
This allows the same code to be run from the command line, within scripts, and from triggers.

Why not just run each script individually?
It is not feasible to run each script one-after-another without performance issues due to compile-at-runtime as well as file access issues when running clients simultaneously which result in the "Unable to acquire writer lock." error. However, for flexibility with global triggers or the command prompt there is value in allowing scripts to be run independently as well as included.

Are there downsides to this approach?
Because the scripts will have multiple-levels of includes, many files are included more than once. However, Genie does not have a preprocessor directive that allows code to be included only as needed, so this script library relies on a custom plugin written by DR_Saet/Scott (not me) which implements a new include syntax called #REQUIRE scriptname.cmd. This assumes that your source scripts are stored in the /Scripts/source directory, and 'assembles' them in the main /Scripts/ directory. Every time you make a change to a script, it needs to be recompiled before use. If you make a change to a script that is included in many other scripts (send.cmd for instance), it is recommended that you '/compile all' in order to update all scripts.

Why are almost all variables local if the idea is a global inter-connected scripting approach?
Global variables are an order of magnitude slower than local variables at runtime, due to the fact that they can trigger global actions in the client. They are simply inefficient. In this project, global variables will be used mostly to store preferences rather than runtime values. Tempoarary globals may be used as appropriate, but I'm still developing guidelines for this.

#Future plans include benchmarking in terms of:
	-robustness (how often script hangs due to unforseen situation)
	-runtime speed, compared to traditional approaches
	-new script development time

# New verbs needed
	Main goal is to complete all combat and utility verbs
	Secondary goal is to complete guild-only and uncommon verbs
	Tertiary (maybe never) goal is to add RP verbs
	recall warrant
	health - needs to set info about wounds (and then tend.cmd if bleeding)
	invoke (for cambrinth)
	spells - set variables for each spell you know, and what other options you have (symbiosis, others?)
	assess - plus set vars
	collect/ forage
	disarm / pick
	tie / untie / wield
	unbundle (for bundling rope)
# New helper scripts needed
	WaitEvalX Waits for a statement to evaluate true, for x seconds (similar concept to WaitforreX)
	

# Todos:
	port ferry script to complete Travel.cmd
	implement test flag which doesn't actually send a command, waits for you to send #parses, for each script
	Implement javascript sorts for skill lists? (Sort skills by rank, smallest to largest)

# Overall verb list (taken from 'verb' command):
	accept (info)

	accuse

	acknowledge

	action (info)

	adjust (info)

	advance - done

	advice

	affix (info)

	aft (info)

	age (info)

	agility (info)

	agree (info)

	aim (info) - done

	alae

	align

	ambush (info)

	analyze (info)

	answer (info)

	applaud

	apply

	appraise

	approach

	approve

	arrange (info)

	ask

	assassin

	assemble

	assess

	assist

	atmosphere

	attack

	auction

	avoid

	awaken

	babble

	backstab

	bail

	balance

	bandage

	bark

	barrage

	barter

	bash - done

	bask

	bawl

	bbs

	beam

	beckon

	befriend

	belch

	beseech

	bet

	bid

	bite - done

	blame

	blanch

	blaze

	blink

	block - done

	bluff

	blush

	bob - done

	boo

	bop

	bounce

	bow

	braid

	brand

	brawl

	break

	breathe

	brush

	bug

	bundle

	butt

	buy

	cackle

	cancel

	cards

	carve

	cast - in progress

	center

	challenge

	chant

	charge (info)

	charisma

	chat

	chatter

	check

	cheer

	chirr

	choke

	choose

	chop - done

	chortle

	chorus

	chuckle

	circle - done

	claim

	claw - done

	clean

	clench

	climb - done

	close - done

	clutch

	coil - coil

	collect

	combat

	combine

	command

	commune

	compare

	consent

	contact

	cough

	count

	cover

	cower

	craft

	crawl

	create

	cringe

	crush

	cry

	currency

	curse

	curtsy

	cut

	dab

	dance

	daydream

	deal

	decay

	decline

	demeanor

	depart

	deposit

	describe

	dig

	dip

	direction

	disarm

	disband

	discern

	discipline

	dismantle

	dismount

	display

	dive

	dodge - done

	drag

	draw - done

	drink

	drool

	drop - done

	duck

	dump

	ear (info)

	ease

	eat (info)

	echocolumn (info)

	elbow - done

	email

	empty (info)

	encumbrance

	evoke

	exchange

	exhale

	experience

	express

	face (info)

	facepalm

	faint

	fall

	fatigue

	favor

	feed

	feint - done

	festival

	fidget

	figure

	fill

	find

	fire - done

	fit

	flags

	flail

	flee

	fletch

	flinch

	flip

	flirt

	fluster

	fly

	focus (info)

	fold

	forage

	forward - not actually a command? (go forward is)

	fret

	frown

	furl

	furrow

	gasp

	gather

	gawk

	gaze

	gem

	gesture

	get

	giggle

	give

	glance

	glare

	glower

	glyph

	gnash

	gobble (info)

	gouge - done

	grab

	grapple - done

	grid

	grimace

	grin

	grind

	groan

	group

	grovel

	growl

	grumble

	grunt

	guard

	gulp

	guzzle (info)

	hack

	hail

	hangback

	harness - in progress

	health

	help

	hiccup

	hide - done

	highfive

	hiss

	hold

	home

	hoot

	how - real verb?

	howl

	hug

	hum

	hunt

	hurl - done

	hush

	huzzah

	ignore

	info - done

	infuse

	inhale

	instruct

	intelligence

	intone

	inventory - done

	invfix

	invite

	invoke (info)

	jab - done

	join

	juggle - RP

	jump - RP, mostly

	justice - done

	khri - mostly done

	kick - done

	kill - not really a command

	kiss - RP

	knee

	kneel - RP, mostly

	knit (info)

	knock

	lace - ?

	language - RP

	latch

	laugh - RP

	lead - paladin only?

	lean - RP, mostly

	leap - RP, mostly

	leave

	lecture - RP

	lick - RP

	lie - RP, mostly

	light

	link

	listen

	load - done

	loan - ?

	lob - done

	lock

	look - done, may need to add additional special cases

	loot - done

	lower - done

	ltb

	lunge - done

	make

	mana

	manipulate

	march

	mark

	mastery (info)

	measure

	meeting

	menu

	meow - RP

	mind

	mix

	moan - RP

	mock - RP

	moor - for boats?

	motion - RP

	mount - RP, mostly

	mumble - RP

	muss - RP

	mutter

	mychar - send info to GMs only? haha, interesting. also echoes to you.

	nag

	news

	nibble

	nod

	notch

	note

	nudge

	observe

	offer

	ooc

	open - done

	order

	overboard

	pace

	paint

	panic

	pant

	parry

	pat

	pathway

	pay

	peer

	perceive

	perform

	pet

	pick

	pin

	pinch

	plant

	play

	playact

	poach - done

	point

	poke

	policy

	ponder

	port

	portrait

	pose

	pound

	pour

	pout

	practice

	praise

	pray

	preach

	predict

	preen

	premium

	prepare - in progress

	procrastinate

	prod

	profile

	prospect

	protect

	pry

	pucker

	pull

	pummel - done

	punch - done

	punish

	purr

	push

	put - done

	puzzle

	quest

	queue

	raise

	ram

	random

	raspberry

	read - in progress, needs more matches

	recall

	recite

	redeem (info)

	refer

	reflex

	refuse

	register

	release - in progress

	relist

	remove

	rename

	rent

	repair

	repent

	report

	request

	reroll

	research

	retreat - done

	return

	review

	ring

	roar

	rofl

	roll

	roshambo

	rotate

	row

	rpa

	rub (info)

	rummage - done

	salute (info)

	say

	scoff

	scout

	scowl

	scrape

	scratch

	scream (info)

	scribe (info)

	search

	sell

	shake

	shape

	share

	sheathe

	shift

	ship

	shiver

	shop

	shove - done

	show

	shriek

	shrug

	shudder

	shuffle

	shun

	sigh

	sign

	signal

	signature - real command?

	simucoin

	simucon

	sing

	sit

	skate

	sketch

	skills

	skin - done

	skip

	sky - real command?

	slam - done

	slap - slap

	sleep

	slice - done

	slide

	slink

	slip

	smell

	smile

	smirk

	smite

	smoke

	smooch

	smudge

	snap

	snarl

	sneak

	sneer

	sneeze

	snicker

	sniffle

	snipe - done

	snivel

	snore

	snort

	snuff

	snuggle

	sob

	song

	sort

	speculate

	spells

	spin

	spit

	splash

	splutter

	sprinkle

	squint

	squirm

	stable

	stalk (info)

	stamina

	stance - done

	stand - done

	starboard

	stare

	status

	steal - in progress, need success messages

	stitch

	stomp (info)

	stop (info)

	store (info)

	stow - done

	strength

	stretch

	string

	strut

	study

	stumble

	submit

	sulk

	summon

	support

	surprise

	surrender

	swap

	swear

	sweat

	sweep - done

	swim

	swing - done

	tackle - done

	tag

	tail

	take

	talk

	tap (info)

	task

	taunt

	tdps

	teach

	tease

	tell

	tellexp

	tellstats

	tend (info)

	think

	throw - done

	thrust - done

	thump (info)

	tickets

	tickle (info)

	tie

	tilt

	time (info)

	tip

	title

	toggle

	toss

	touch (info)

	trace (info)

	track

	train

	transfer

	trill (info)

	trim

	trudge

	tune

	turn

	twiddle (info)

	unbraid

	unbundle

	uncoil

	unfold

	unfurl

	unhide

	unlatch (info)

	unload

	unlock

	unregister

	unroll

	unstore

	untangle

	untie (info)

	unwrap

	verb - display this list

	vote

	waggle

	wail

	wait

	wake

	walk - real command?

	warn

	wash

	watch

	wave

	wealth

	wear

	weather

	weave - done

	wedding

	weep

	what

	wheeze

	where

	whimper

	whine

	whirlwind

	whisper (info)

	whistle (info)

	who

	why

	wield

	wince

	wink

	wipe

	wisdom

	withdraw

	wobble

	wring

	write

	xml

	yank

	yawn

	yell

	yelp

	yes