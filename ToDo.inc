port ferry script to complete Travel.cmd

New verbs needed
justice - set info about current room and warrant/necromancer status
hunt
health - needs to set info about wounds
info - update to have numerical burden levels
prepare - needs spell-specific strings so that success/failure is accurate
cast - same as prepare
target - same as cast, essentially, plus extra code for ensuring valid target
power/perceive - set mana levels appropriately
invoke (for cambrinth)
spells - set variables for each spell you know, and what other options you have (symbiosis, others?)



# TODO: implement test flag which doesn't actually send a command, waits for you to send #parses, for each script

Common reasons for a command to fail:

RT
Too many typeaheads
Stunned
In Combat
Not standing
Not visible (hidden or invisible)
.....
Not holding item we're trying to manipulate
Can't find item


Implement javascript sorts for skill lists?
Sort skills by rank, smallest to largest?

Overall verb list (take from 'verb' command):
  accept (info)
  accuse
  acknowledge
  action (info)
  adjust (info)
  advance
  advice
  affix (info)
  aft (info)
  age (info)
  agility (info)
  agree (info)
  aim (info)
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
  bash
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
  bite
  blame
  blanch
  blaze
  blink
  block
  bluff
  blush
  bob
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
  chop
  chortle
  chorus
  chuckle
  circle
  claim
  claw
  clean
  clench
  climb
  close
  clutch
  coil
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
  dodge
  drag
  draw
  drink
  drool
  drop
  duck
  dump
  ear (info)
  ease
  eat (info)
  echocolumn (info)
  elbow
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
  feint
  festival
  fidget
  figure
  fill
  find
  fire
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
  forward
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
  gouge
  grab
  grapple
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
  harness
  health
  help
  hiccup
  hide
  highfive
  hiss
  hold
  home
  hoot
  how
  howl
  hug
  hum
  hunt
  hurl
  hush
  huzzah
  ignore
  info
  infuse
  inhale
  instruct
  intelligence
  intone
  inventory
  invfix
  invite
  invoke (info)
  jab - done
  join
  juggle - RP
  jump - RP, mostly
  justice
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
  load
  loan - ?
  lob
  lock
  look
  loot
  lower
  ltb
  lunge
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
  open
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
  poach
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
  procrastinate
  prod
  profile
  prospect
  protect
  pry
  pucker
  pull
  pummel
  punch
  punish
  purr
  push
  put
  puzzle
  quest
  queue
  raise
  ram
  random
  raspberry
  read
  recall
  recite
  redeem (info)
  refer
  reflex
  refuse
  register
  release
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
  retreat
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
  rummage
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
  shove
  show
  shriek
  shrug
  shudder
  shuffle
  shun
  sigh
  sign
  signal
  signature
  simucoin
  simucon
  sing
  sit
  skate
  sketch
  skills
  skin
  skip
  sky
  slam
  slap
  sleep
  slice
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
  snipe
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
  stance
  stand
  starboard
  stare
  status
  steal
  stitch
  stomp (info)
  stop (info)
  store (info)
  stow
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
  sweep
  swim
  swing
  tackle
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
  throw
  thrust
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
  walk
  warn
  wash
  watch
  wave
  wealth
  wear
  weather
  weave
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