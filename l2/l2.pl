solve_crossword(W,C) :-
	
	member([HA1,HA2,HA3,HA4,HA5],W),
	member([HB1,HB2,HB3,HB4,HB5],W),
	member([HC1,HC2,HC3,HC4,HC5],W),
	
	member([HA1,VA2,HB1,VA4,HC1],W),
	member([HA3,VB2,HB3,VB4,HC3],W),
	member([HA5,VC2,HB5,VC4,HC5],W),	
	
	
	
	C = [  	
			[HA1,HA2,HA3,HA4,HA5],
			[HB1,HB2,HB3,HB4,HB5],
			[HC1,HC2,HC3,HC4,HC5],
			
			[HA1,VA2,HB1,VA4,HC1],
			[HA3,VB2,HB3,VB4,HC3],
			[HA5,VC2,HB5,VC4,HC5] 
		].
			
write_crossword(C) :-
	C = [  	
			[HA1,HA2,HA3,HA4,HA5],
			[HB1,HB2,HB3,HB4,HB5],
			[HC1,HC2,HC3,HC4,HC5],
			
			[_,VA2,_,VA4,_],
			[_,VB2,_,VB4,_],
			[_,VC2,_,VC4,_]
		],
			
	format([HA1,HA2,HA3,HA4,HA5], []),	nl,
	format([VA2,32,VB2,32,VC2], []),	nl,
	format([HB1,HB2,HB3,HB4,HB5], []),	nl,
	format([VA4,32,VB4,32,VC4], []),	nl,
	format([HC1,HC2,HC3,HC4,HC5], [])	.

word_weight([], 0).
word_weight([X|Xs], N) :-
		member(X, "EAIONRTLSU"), word_weight(Xs, M), N is M+1.
word_weight([X|Xs], N) :-
		member(X, "DG"), word_weight(Xs, M), N is M+2.
word_weight([X|Xs], N) :-
		member(X, "BCMP"), word_weight(Xs, M), N is M+3.
word_weight([X|Xs], N) :-
		member(X, "FHVWY"), word_weight(Xs, M), N is M+4.
word_weight([X|Xs], N) :-
		member(X, "K"), word_weight(Xs, M), N is M+5.
word_weight([X|Xs], N) :-
		member(X, "JX"), word_weight(Xs, M), N is M+8.
word_weight([X|Xs], N) :-
		member(X, "QZ"), word_weight(Xs, M), N is M+9.
		
require_min_weight([], _ , []).
require_min_weight([X|Xs], W, F) :-
	word_weight(X, Y),
	(W =< Y -> F = [X|UT] ; F = UT),
	require_min_weight(Xs, W, UT).	

better_crossword(W, C) :-
	words(X),
	require_min_weight(X, W, F),
	solve_crossword(F, C).
	

% GNU Prolog is not good at reading long lists of "string",
% and run out of stack space for any non-trivial dataset unless
% we use the following trick:
%   1. Read a list of atoms
%   2. Convert the list of atoms to a list of strings.
%
% If you issue the goal "words(X)", you will unify X to 
% a list of strings.
%

words(X) :- listofterms(Y), convertterms(Y, X).
convertterms([], []).
convertterms([X|Xs], [Y|Ys]) :- 
	atom_codes(X,Y), convertterms(Xs, Ys).
listofterms([
'ABACK',
'ABAFT',
'ABASE',
'ABASH',
'ABATE',
'ABBEY',
'ABBOT',
'ABEAM',
'ABHOR',
'ABIDE',
'ABODE',
'ABORT',
'ABOUT',
'ABOVE',
'ABSTR',
'ABUSE',
'ABYSM',
'ABYSS',
'ACORN',
'ACRID',
'ACTOR',
'ACUTE',
'ADAGE',
'ADAPT',
'ADDER',
'ADDLE',
'ADDNL',
'ADEPT',
'ADIEU',
'ADIOS',
'ADMAN',
'ADMIN',
'ADMIT',
'ADMIX',
'ADOBE',
'ADOPT',
'ADORE',
'ADORN',
'ADULT',
'AEGIS',
'AERIE',
'AFFIX',
'AFIRE',
'AFOOT',
'AFTER',
'AGAIN',
'AGAPE',
'AGATE',
'AGAVE',
'AGENT',
'AGILE',
'AGLOW',
'AGONY',
'AGORA',
'AGREE',
'AHEAD',
'AISLE',
'ALARM',
'ALBUM',
'ALDER',
'ALERT',
'ALIAS',
'ALIBI',
'ALIEN',
'ALIGN',
'ALIKE',
'ALIVE',
'ALKYD',
'ALLAH',
'ALLAY',
'ALLEY',
'ALLOT',
'ALLOW',
'ALLOY',
'ALOFT',
'ALOHA',
'ALONE',
'ALONG',
'ALOOF',
'ALOUD',
'ALTAR',
'ALTER',
'AMAIN',
'AMASS',
'AMAZE',
'AMBER',
'AMBLE',
'AMEBA',
'AMEND',
'AMISS',
'AMITY',
'AMONG',
'AMOUR',
'AMPLE',
'AMPUL',
'AMUCK',
'AMUSE',
'ANENT',
'ANGEL',
'ANGER',
'ANGLE',
'ANGLO',
'ANGRY',
'ANGST',
'ANGUS',
'ANION',
'ANISE',
'ANKLE',
'ANNEX',
'ANNOY',
'ANNUL',
'ANODE',
'ANTIC',
'ANVIL',
'AORTA',
'APACE',
'APART',
'APEAK',
'APHID',
'APHIS',
'APORT',
'APPLE',
'APPLY',
'APRIL',
'APRON',
'ARBOR',
'ARDOR',
'ARENA',
'ARGON',
'ARGOT',
'ARGUE',
'ARISE',
'ARITH',
'ARMOR',
'AROMA',
'ARRAS',
'ARRAY',
'ARROW',
'ARSON',
'ARYAN',
'ASCOT',
'ASHEN',
'ASIAN',
'ASIDE',
'ASKEW',
'ASPEN',
'ASPIC',
'ASSAY',
'ASSET',
'ASSOC',
'ASTER',
'ASTIR',
'ATILT',
'ATLAS',
'ATOLL',
'ATONE',
'ATTAR',
'ATTIC',
'AUDIO',
'AUDIT',
'AUGER',
'AUGHT',
'AUGUR',
'AURAL',
'AURAR',
'AUXIN',
'AVAIL',
'AVAST',
'AVERT',
'AVGAS',
'AVIAN',
'AVOID',
'AWAIT',
'AWAKE',
'AWARD',
'AWARE',
'AWASH',
'AWFUL',
'AXIAL',
'AXIOM',
'AZTEC',
'AZURE',
'BABEL',
'BACON',
'BADGE',
'BAGEL',
'BAGGY',
'BAIRN',
'BAIZA',
'BAIZE',
'BALKY',
'BALMY',
'BALSA',
'BANAL',
'BANDY',
'BANJO',
'BANNS',
'BANTU',
'BARGE',
'BARON',
'BASAL',
'BASIC',
'BASIL',
'BASIN',
'BASIS',
'BASSO',
'BASTE',
'BATCH',
'BATHE',
'BATIK',
'BATON',
'BATTY',
'BAWDY',
'BAYOU',
'BEACH',
'BEANO',
'BEARD',
'BEAST',
'BEDEW',
'BEECH',
'BEEFY',
'BEFIT',
'BEFOG',
'BEGET',
'BEGIN',
'BEGUM',
'BEIGE',
'BEING',
'BELAY',
'BELCH',
'BELIE',
'BELLE',
'BELLS',
'BELLY',
'BELOW',
'BENCH',
'BENNY',
'BERET',
'BERRY',
'BERTH',
'BERYL',
'BESET',
'BESOM',
'BESOT',
'BETEL',
'BEVEL',
'BEZEL',
'BHANG',
'BIBLE',
'BIDDY',
'BIDET',
'BIGHT',
'BIGOT',
'BILGE',
'BILLY',
'BINGE',
'BINGO',
'BIPED',
'BIRCH',
'BIRTH',
'BISON',
'BITCH',
'BLACK',
'BLADE',
'BLAIN',
'BLAME',
'BLAND',
'BLANK',
'BLARE',
'BLAST',
'BLAZE',
'BLEAK',
'BLEAR',
'BLEAT',
'BLEED',
'BLEND',
'BLESS',
'BLIMP',
'BLIND',
'BLINK',
'BLISS',
'BLITZ',
'BLOAT',
'BLOCK',
'BLOND',
'BLOOD',
'BLOOM',
'BLOWY',
'BLUES',
'BLUET',
'BLUFF',
'BLUNT',
'BLURB',
'BLURT',
'BLUSH',
'BOARD',
'BOAST',
'BOBBY',
'BOGEY',
'BOGUS',
'BOLUS',
'BONER',
'BONGO',
'BONNY',
'BONUS',
'BONZE',
'BOOBY',
'BOOST',
'BOOTH',
'BOOTY',
'BOOZE',
'BORAX',
'BORNE',
'BORON',
'BOSKY',
'BOSOM',
'BOSUN',
'BOTCH',
'BOUGH',
'BOULE',
'BOUND',
'BOURN',
'BOWEL',
'BOWER',
'BOXER',
'BRACE',
'BRACT',
'BRAID',
'BRAIN',
'BRAKE',
'BRAND',
'BRASH',
'BRASS',
'BRAVE',
'BRAVO',
'BRAWL',
'BRAWN',
'BRAZE',
'BREAD',
'BREAK',
'BREAM',
'BREED',
'BRIAR',
'BRIBE',
'BRICK',
'BRIDE',
'BRIEF',
'BRIER',
'BRINE',
'BRING',
'BRINK',
'BRISK',
'BROAD',
'BROIL',
'BROKE',
'BROOD',
'BROOK',
'BROOM',
'BROTH',
'BROWN',
'BRUIN',
'BRUIT',
'BRUNT',
'BRUSH',
'BRUTE',
'BUDDY',
'BUDGE',
'BUGGY',
'BUGLE',
'BUILD',
'BULGE',
'BULKY',
'BULLY',
'BUNCH',
'BUNCO',
'BUNNY',
'BURGH',
'BURLY',
'BURRO',
'BURST',
'BUSBY',
'BUTTE',
'BUTUT',
'BUXOM',
'BYLAW',
'BYWAY',
'CABAL',
'CABBY',
'CABIN',
'CABLE',
'CACAO',
'CACHE',
'CADDY',
'CADET',
'CADGE',
'CADRE',
'CAGEY',
'CAIRN',
'CAJUN',
'CALIF',
'CALLA',
'CALVE',
'CALYX',
'CAMEL',
'CAMEO',
'CANAL',
'CANDY',
'CANNA',
'CANNY',
'CANOE',
'CANON',
'CANTO',
'CAPER',
'CAPON',
'CARAT',
'CARET',
'CARGO',
'CARNY',
'CAROL',
'CAROM',
'CARRY',
'CARVE',
'CASTE',
'CATCH',
'CATER',
'CATTY',
'CAULK',
'CAUSE',
'CAVIL',
'CEASE',
'CECUM',
'CEDAR',
'CELLO',
'CHAFE',
'CHAFF',
'CHAIN',
'CHAIR',
'CHALK',
'CHAMP',
'CHANT',
'CHAOS',
'CHAPS',
'CHARD',
'CHARM',
'CHART',
'CHARY',
'CHASE',
'CHASM',
'CHEAP',
'CHEAT',
'CHECK',
'CHEEK',
'CHEEP',
'CHEER',
'CHELA',
'CHERT',
'CHESS',
'CHEST',
'CHEWY',
'CHIAO',
'CHICK',
'CHIDE',
'CHIEF',
'CHILD',
'CHILI',
'CHILL',
'CHIME',
'CHIMP',
'CHINA',
'CHINE',
'CHINK',
'CHINO',
'CHIRP',
'CHIVE',
'CHOCK',
'CHOIR',
'CHOKE',
'CHOMP',
'CHOPS',
'CHORD',
'CHORE',
'CHOSE',
'CHRON',
'CHUCK',
'CHUMP',
'CHUNK',
'CHURL',
'CHURN',
'CHUTE',
'CIDER',
'CIGAR',
'CINCH',
'CIRCA',
'CIVET',
'CIVIC',
'CIVIL',
'CLACK',
'CLAIM',
'CLAMP',
'CLANG',
'CLANK',
'CLASH',
'CLASP',
'CLASS',
'CLEAN',
'CLEAR',
'CLEAT',
'CLEFT',
'CLERK',
'CLICK',
'CLIFF',
'CLIMB',
'CLIME',
'CLING',
'CLINK',
'CLOAK',
'CLOCK',
'CLOSE',
'CLOTH',
'CLOUD',
'CLOUT',
'CLOVE',
'CLOWN',
'CLUCK',
'CLUMP',
'CLUNG',
'CMSGT',
'COACH',
'COAST',
'COBRA',
'COCKY',
'COCOA',
'CODEX',
'COLIC',
'COLON',
'COLOR',
'COMBO',
'COMDG',
'COMDR',
'COMDT',
'COMER',
'COMET',
'COMFY',
'COMIC',
'COMMA',
'COMMO',
'CONCH',
'CONEY',
'CONGA',
'CONIC',
'CONST',
'CONTD',
'CONTG',
'CONTR',
'COPRA',
'COPSE',
'CORAL',
'CORNY',
'CORPS',
'COUCH',
'COUGH',
'COULD',
'COUNT',
'COUPE',
'COURT',
'COVEN',
'COVER',
'COVET',
'COVEY',
'COWER',
'COYPU',
'COZEN',
'CRACK',
'CRAFT',
'CRAMP',
'CRANE',
'CRANK',
'CRAPE',
'CRAPS',
'CRASH',
'CRASS',
'CRATE',
'CRAVE',
'CRAWL',
'CRAZE',
'CRAZY',
'CREAK',
'CREAM',
'CREDO',
'CREED',
'CREEK',
'CREEL',
'CREEP',
'CREME',
'CREPE',
'CRESC',
'CRESS',
'CREST',
'CRICK',
'CRIER',
'CRIME',
'CRIMP',
'CRISP',
'CROAK',
'CROCK',
'CRONE',
'CRONY',
'CROOK',
'CROON',
'CROSS',
'CROUP',
'CROWD',
'CROWN',
'CRUDE',
'CRUEL',
'CRUET',
'CRUMB',
'CRUSE',
'CRUSH',
'CRUST',
'CRYPT',
'CRYST',
'CUBAN',
'CUBIC',
'CUBIT',
'CUPID',
'CURIA',
'CURIO',
'CURRY',
'CURSE',
'CURVE',
'CUTUP',
'CYCLE',
'CYNIC',
'CZECH',
'DACHA',
'DADDY',
'DAFFY',
'DAILY',
'DAIRY',
'DAISY',
'DALLY',
'DANCE',
'DANDY',
'DATED',
'DATUM',
'DAUNT',
'DAVIT',
'DEATH',
'DEBAR',
'DEBIT',
'DEBUT',
'DECAL',
'DECAY',
'DECOR',
'DECOY',
'DECRY',
'DEFER',
'DEFOG',
'DEGAS',
'DEICE',
'DEIFY',
'DEIGN',
'DEISM',
'DEITY',
'DELAY',
'DELFT',
'DELTA',
'DELVE',
'DEMON',
'DEMUR',
'DENIM',
'DENSE',
'DEPOT',
'DEPTH',
'DERBY',
'DERIV',
'DETER',
'DEUCE',
'DEVIL',
'DIARY',
'DIGIT',
'DINAR',
'DINER',
'DINGO',
'DINGY',
'DINKY',
'DIODE',
'DIRGE',
'DIRTY',
'DISCO',
'DISTN',
'DISTR',
'DITCH',
'DITTO',
'DITTY',
'DIVAN',
'DIVOT',
'DIZZY',
'DLITT',
'DODGE',
'DOGGY',
'DOGIE',
'DOGMA',
'DOILY',
'DOLLY',
'DOLOR',
'DONOR',
'DONUT',
'DOPEY',
'DOUBT',
'DOUGH',
'DOUSE',
'DOWDY',
'DOWEL',
'DOWER',
'DOWNY',
'DOWRY',
'DOWSE',
'DOYEN',
'DOZEN',
'DRAFT',
'DRAIN',
'DRAKE',
'DRAMA',
'DRANK',
'DRAPE',
'DRAWL',
'DREAD',
'DREAM',
'DREAR',
'DRESS',
'DRIER',
'DRIFT',
'DRILL',
'DRILY',
'DRINK',
'DRIVE',
'DROLL',
'DRONE',
'DROOL',
'DROOP',
'DROSS',
'DROVE',
'DROWN',
'DRUID',
'DRUNK',
'DRUPE',
'DRYAD',
'DRYER',
'DUCAL',
'DUCAT',
'DUCHY',
'DUMMY',
'DUMPS',
'DUMPY',
'DUNCE',
'DUPLE',
'DUSKY',
'DUTCH',
'DWARF',
'DWELL',
'DYING',
'EAGER',
'EAGLE',
'EARED',
'EARLY',
'EARTH',
'EASEL',
'EAVES',
'EBONY',
'ECLAT',
'EDEMA',
'EDICT',
'EDUCE',
'EERIE',
'EGRET',
'EIDER',
'EIGHT',
'EJECT',
'ELAND',
'ELATE',
'ELBOW',
'ELDER',
'ELECT',
'ELEGY',
'ELIDE',
'ELITE',
'ELOPE',
'ELUDE',
'ELVER',
'ELVES',
'EMBED',
'EMBER',
'EMCEE',
'EMEND',
'EMERY',
'EMOTE',
'EMPTY',
'ENACT',
'ENDOW',
'ENDUE',
'ENEMA',
'ENEMY',
'ENJOY',
'ENNUI',
'ENSUE',
'ENTER',
'ENTOM',
'ENTRY',
'ENVOI',
'ENVOY',
'EPOCH',
'EPOXY',
'EQUAL',
'EQUIP',
'EQUIV',
'ERASE',
'ERECT',
'ERGOT',
'ERODE',
'ERROR',
'ERUPT',
'ESSAY',
'ESTER',
'ETHER',
'ETHOS',
'ETHYL',
'ETUDE',
'EVADE',
'EVENT',
'EVERY',
'EVICT',
'EVOKE',
'EXACT',
'EXALT',
'EXCEL',
'EXERT',
'EXILE',
'EXIST',
'EXPEL',
'EXPTL',
'EXTOL',
'EXTRA',
'EXUDE',
'EXULT',
'EXURB',
'EYRIE',
'EYRIR',
'FABLE',
'FACET',
'FAGOT',
'FAINT',
'FAIRY',
'FAITH',
'FAKIR',
'FALSE',
'FANCY',
'FARCE',
'FATAL',
'FATED',
'FATTY',
'FAULT',
'FAUNA',
'FAVOR',
'FEAST',
'FEAZE',
'FECES',
'FEIGN',
'FEINT',
'FELLY',
'FELON',
'FEMUR',
'FENCE',
'FERAL',
'FERRY',
'FETAL',
'FETCH',
'FETID',
'FETUS',
'FEVER',
'FEWER',
'FIBER',
'FICHE',
'FICHU',
'FIELD',
'FIEND',
'FIERY',
'FIFTH',
'FIFTY',
'FIGHT',
'FILAR',
'FILCH',
'FILLY',
'FILTH',
'FINAL',
'FINCH',
'FINIS',
'FINNY',
'FIORD',
'FIRST',
'FIRTH',
'FISHY',
'FIXED',
'FJORD',
'FLAIL',
'FLAIR',
'FLAKE',
'FLAME',
'FLANK',
'FLARE',
'FLASH',
'FLASK',
'FLECK',
'FLEER',
'FLEET',
'FLESH',
'FLICK',
'FLIED',
'FLIER',
'FLING',
'FLINT',
'FLIRT',
'FLOAT',
'FLOCK',
'FLOOD',
'FLOOR',
'FLORA',
'FLOSS',
'FLOUR',
'FLOUT',
'FLOWN',
'FLUFF',
'FLUID',
'FLUKE',
'FLUME',
'FLUNG',
'FLUNK',
'FLUSH',
'FLUTE',
'FLYBY',
'FLYER',
'FLCUS',
'FOEHN',
'FOIST',
'FOLIO',
'FOLLY',
'FORAY',
'FORCE',
'FORGE',
'FORGO',
'FORTE',
'FORTH',
'FORTY',
'FORUM',
'FOUND',
'FOUNT',
'FOXED',
'FOYER',
'FRAIL',
'FRAME',
'FRANC',
'FRANK',
'FRAUD',
'FREAK',
'FRESH',
'FRIAR',
'FRILL',
'FRISK',
'FRIZZ',
'FROCK',
'FROND',
'FRONT',
'FROST',
'FROTH',
'FROWN',
'FROZE',
'FRUIT',
'FRYER',
'FSLIC',
'FUDGE',
'FUGUE',
'FULLY',
'FUNKY',
'FUNNY',
'FUROR',
'FURRY',
'FURZE',
'FUSEE',
'FUSSY',
'FUSTY',
'FUZZY',
'GABBY',
'GABLE',
'GAFFE',
'GAILY',
'GAMIN',
'GAMUT',
'GAUDY',
'GAUGE',
'GAUNT',
'GAUSS',
'GAUZE',
'GAVEL',
'GAWKY',
'GEESE',
'GELID',
'GENIE',
'GENRE',
'GENUS',
'GEODE',
'GETUP',
'GHOST',
'GHOUL',
'GIANT',
'GIDDY',
'GIMPY',
'GIPSY',
'GIRTH',
'GIVEN',
'GIZMO',
'GLADE',
'GLAND',
'GLANS',
'GLARE',
'GLASS',
'GLAZE',
'GLEAM',
'GLEAN',
'GLEBE',
'GLIDE',
'GLINT',
'GLOAT',
'GLOBE',
'GLOOM',
'GLORY',
'GLOSS',
'GLOVE',
'GLOZE',
'GNARL',
'GNASH',
'GNOME',
'GODLY',
'GONAD',
'GONER',
'GOODY',
'GOFFY',
'GOOSE',
'GORGE',
'GORSE',
'GOUDA',
'GOUGE',
'GOURD',
'GRACE',
'GRADE',
'GRAFT',
'GRAIL',
'GRAIN',
'GRAND',
'GRANT',
'GRAPE',
'GRAPH',
'GRASP',
'GRASS',
'GRATE',
'GRAVE',
'GRAVY',
'GRAZE',
'GREAT',
'GREBE',
'GREED',
'GREEK',
'GREEN',
'GREET',
'GRIEF',
'GRILL',
'GRIME',
'GRIND',
'GRIPE',
'GRIST',
'GRITS',
'GROAN',
'GROAT',
'GROIN',
'GROOM',
'GROPE',
'GROSS',
'GROSZ',
'GROUP',
'GROUT',
'GROVE',
'GROWL',
'GRUEL',
'GRUFF',
'GRUNT',
'GUANO',
'GUARD',
'GUAVA',
'GUESS',
'GUEST',
'GUIDE',
'GUILD',
'GUILE',
'GUILT',
'GUISE',
'GULCH',
'GULLY',
'GUMBO',
'GUNNY',
'GUPPY',
'GUSHY',
'GUSTO',
'GUTTY',
'GUYOT',
'GYPSY',
'HABIT',
'HADES',
'HAIKU',
'HAIRY',
'HAJJI',
'HALER',
'HALLO',
'HALVE',
'HANDY',
'HAOLE',
'HAPLY',
'HAPPY',
'HARDY',
'HAREM',
'HARPY',
'HARRY',
'HARSH',
'HASTE',
'HATCH',
'HAUNT',
'HAVEN',
'HAVOC',
'HAZEL',
'HEADY',
'HEART',
'HEATH',
'HEAVE',
'HEAVY',
'HEDGE',
'HEFTY',
'HEIST',
'HELIX',
'HELLO',
'HELOT',
'HELVE',
'HENCE',
'HENNA',
'HERON',
'HERTZ',
'HINDI',
'HINGE',
'HITCH',
'HIVES',
'HOARD',
'HOARY',
'HOBBY',
'HOGAN',
'HOIST',
'HOKUM',
'HOLLO',
'HOLLY',
'HOMER',
'HOMEY',
'HONEY',
'HONOR',
'HOOEY',
'HORDE',
'HORSE',
'HOTEL',
'HOUND',
'HOURI',
'HOUSE',
'HOVEL',
'HOVER',
'HUMAN',
'HUMID',
'HUMOR',
'HUMUS',
'HUNCH',
'HURON',
'HURRY',
'HUSKY',
'HUSSY',
'HUTCH',
'HYDRA',
'HYDRO',
'HYENA',
'HYING',
'HYMEN',
'ICHOR',
'ICING',
'ICTUS',
'IDEAL',
'IDIOM',
'IDIOT',
'IDYLL',
'IGLOO',
'ILEUM',
'IMAGE',
'IMAGO',
'IMBED',
'IMBUE',
'IMPEL',
'IMPER',
'IMPLY',
'INANE',
'INCOG',
'INCUR',
'INCUS',
'INDEF',
'INDEX',
'INDIC',
'INDUE',
'INEPT',
'INERT',
'INFER',
'INGLE',
'INGOT',
'INLAY',
'INLET',
'INNER',
'INPUT',
'INSET',
'INSOL',
'INSTR',
'INTER',
'INURE',
'INURN',
'IRAWI',
'IRATE',
'IRISH',
'IRONY',
'IRREG',
'ISLAM',
'ISLET',
'ISSUE',
'IVORY',
'JABOT',
'JADED',
'JALAP',
'JAPAN',
'JAUNT',
'JAZZY',
'JEANS',
'JELLY',
'JENNY',
'JETTY',
'JEWEL',
'JEWRY',
'JIFFY',
'JIHAD',
'JIMMY',
'JOINT',
'JOIST',
'JOKER',
'JOLLY',
'JOUST',
'JUDGE',
'JUICE',
'JUICY',
'JULEP',
'JUMBO',
'JUMPY',
'JUNCO',
'JUNTA',
'JUNTO',
'JUROR',
'KABOB',
'KAPOK',
'KAPUT',
'KARAT',
'KARMA',
'KARST',
'KAYAK',
'KAZOO',
'KEBAB',
'KEDGE',
'KETCH',
'KHAKI',
'KIOSK',
'KIOWA',
'KITTY',
'KNACK',
'KNAVE',
'KNEAD',
'KNEEL',
'KNELL',
'KNIFE',
'KNISH',
'KNOCK',
'KNOLL',
'KNOUT',
'KNURL',
'KOALA',
'KOOKY',
'KORAN',
'KRAAL',
'KRAUT',
'KRONA',
'KRONE',
'KUDOS',
'KULAK',
'KURUS',
'LABEL',
'LABOR',
'LADEN',
'LADLE',
'LAGER',
'LAIRD',
'LAITY',
'LAMIA',
'LANAI',
'LANCE',
'LANKY',
'LAPEL',
'LAPIN',
'LAPSE',
'LARCH',
'LARGE',
'LARGO',
'LARVA',
'LASER',
'LASSO',
'LATCH',
'LATEX',
'LATHE',
'LATIN',
'LAUGH',
'LAYER',
'LAZAR',
'LEACH',
'LEARN',
'LEASE',
'LEASH',
'LEAST',
'LEAVE',
'LEDGE',
'LEECH',
'LEERY',
'LEGAL',
'LEGGY',
'LEGIS',
'LEGIT',
'LEMON',
'LEMUR',
'LEONE',
'LEPER',
'LETUP',
'LEVEE',
'LEVEL',
'LEVER',
'LIBEL',
'LICIT',
'LIEGE',
'LIEUT',
'LIFER',
'LIGHT',
'LIKEN',
'LILAC',
'LIMBO',
'LIMIT',
'LINEN',
'LINER',
'LINGO',
'LINKS',
'LISLE',
'LISTS',
'LITER',
'LITHE',
'LIVEN',
'LIVER',
'LIVES',
'LIVID',
'LLAMA',
'LLANO',
'LOATH',
'LOBBY',
'LOCAL',
'LOCUS',
'LODGE',
'LOESS',
'LOFTY',
'LOGIC',
'LONER',
'LOONY',
'LOOSE',
'LORRY',
'LOTUS',
'LOUSE',
'LOUSY',
'LOWER',
'LOWLY',
'LOYAL',
'LUCID',
'LUCKY',
'LUCRE',
'LUNAR',
'LUNCH',
'LUNGE',
'LURCH',
'LURID',
'LUSTY',
'LYING',
'LYMPH',
'LYNCH',
'LYRIC',
'MACAW',
'MACRO',
'MADAM',
'MAFIA',
'MAGIC',
'MAGMA',
'MAIZE',
'MAJOR',
'MALAY',
'MAMBO',
'MANES',
'MANGE',
'MANGO',
'MANIA',
'MANIC',
'MANLY',
'MANNA',
'MANOR',
'MANSE',
'MANTA',
'MANUF',
'MAORI',
'MAPLE',
'MARCH',
'MARGE',
'MARRY',
'MARSH',
'MASER',
'MASON',
'MATCH',
'MATZO',
'MAUVE',
'MAVEN',
'MAVIS',
'MAXIM',
'MAYBE',
'MAYOR',
'MECCA',
'MEDAL',
'MEDIA',
'MEDIC',
'MELEE',
'MELON',
'MERCY',
'MERGE',
'MERIT',
'MERRY',
'METAL',
'METER',
'METRE',
'METRO',
'MIAMI',
'MICRO',
'MIDDY',
'MIDGE',
'MIDST',
'MIGHT',
'MILCH',
'MIMIC',
'MINCE',
'MINIM',
'MINOR',
'MINUS',
'MIRTH',
'MISER',
'MISTY',
'MITER',
'MLLES',
'MODEL',
'MODIF',
'MOGUL',
'MOIRE',
'MOIST',
'MOLAR',
'MONEY',
'MONGO',
'MONTH',
'MOODY',
'MOOSE',
'MORAL',
'MORAY',
'MOREL',
'MORES',
'MORON',
'MOSEY',
'MOTEL',
'MOTET',
'MOTIF',
'MOTOR',
'MOTTO',
'MOULD',
'MOULT',
'MOUND',
'MOUNT',
'MOURN',
'MOUSE',
'MOUSY',
'MOUTH',
'MOVER',
'MOVIE',
'MUCUS',
'MUFTI',
'MUGGY',
'MULCH',
'MULCT',
'MUMMY',
'MUMPS',
'MUNCH',
'MURAL',
'MUSHY',
'MUSIC',
'MUSTY',
'MYRRH',
'NAACP',
'NABOB',
'NACRE',
'NADIR',
'NAIAD',
'NAIRA',
'NAIVE',
'NAKED',
'NARIS',
'NASAL',
'NASTY',
'NATAL',
'NATTY',
'NAVAL',
'NAVEL',
'NEATH',
'NEEDS',
'NEEDY',
'NEGRO',
'NEGUS',
'NEIGH',
'NERVE',
'NERVY',
'NEVER',
'NEVUS',
'NEWEL',
'NEWLY',
'NEWSY',
'NEXUS',
'NGWEE',
'NICHE',
'NIECE',
'NIFTY',
'NIGHT',
'NINNY',
'NIPPY',
'NISEI',
'NITER',
'NITRO',
'NOBLE',
'NODDY',
'NOHOW',
'NOISE',
'NOISY',
'NOMAD',
'NONCE',
'NONES',
'NOOSE',
'NORSE',
'NORTH',
'NOTCH',
'NOTED',
'NOVEL',
'NOWAY',
'NUDGE',
'NUMIS',
'NURSE',
'NUTTY',
'NYLON',
'NYMPH',
'OAKUM',
'OASIS',
'OBESE',
'OCCAS',
'OCCUR',
'OCEAN',
'OCHER',
'OCTET',
'ODIUM',
'OFFAL',
'OFFER',
'OFTEN',
'OLDEN',
'OLDIE',
'OLIVE',
'OMAHA',
'ONION',
'ONSET',
'OPERA',
'OPINE',
'OPIUM',
'OPTIC',
'ORATE',
'ORBIT',
'ORDER',
'ORGAN',
'ORIEL',
'ORRIS',
'OSAGE',
'OSIER',
'OTHER',
'OTTER',
'OUGHT',
'OUNCE',
'OUTDO',
'OUTER',
'OUTGO',
'OUTRE',
'OVARY',
'OVATE',
'OVERT',
'OVOID',
'OVULE',
'OWLET',
'OXBOW',
'OXIDE',
'OZONE',
'PACER',
'PADDY',
'PADRE',
'PAEAN',
'PAGAN',
'PAINT',
'PAISA',
'PALMY',
'PALSY',
'PAMPA',
'PANDA',
'PANEL',
'PANIC',
'PANSY',
'PANTS',
'PAPAL',
'PAPAW',
'PAPER',
'PARCH',
'PARKA',
'PARRY',
'PARSE',
'PARTY',
'PASHA',
'PASSE',
'PASTA',
'PASTE',
'PASTY',
'PATCH',
'PATEN',
'PATIO',
'PATSY',
'PATTY',
'PAUSE',
'PEACE',
'PEACH',
'PEARL',
'PECAN',
'PEDAL',
'PEEVE',
'PIKOE',
'PENAL',
'PENCE',
'PENIS',
'PENNI',
'PENNY',
'PEONY',
'PERCH',
'PERIL',
'PESKY',
'PETAL',
'PETER',
'PETTY',
'PEWEE',
'PHAGE',
'PHARM',
'PHASE',
'PHIAL',
'PHLOX',
'PHONE',
'PHONO',
'PHONY',
'PHOTO',
'PIANO',
'PICKY',
'PICOT',
'PIECE',
'PIETY',
'PIGMY',
'PIKER',
'PILAF',
'PILES',
'PILOT',
'PINCH',
'PINON',
'PINTO',
'PINUP',
'PIOUS',
'PIQUE',
'PITCH',
'PITHY',
'PITON',
'PIVOT',
'PIXIE',
'PIZZ',
'PLACE',
'PLAID',
'PLAIN',
'PLAIT',
'PLANE',
'PLANK',
'PLANT',
'PLASH',
'PLATE',
'PLATY',
'PLAYA',
'PLAZA',
'PLEAD',
'PLEAT',
'PLEBE',
'PLEBS',
'PLUCK',
'PLUMB',
'PLUME',
'PLUMP',
'PLUNK',
'PLUSH',
'PLUTO',
'POACH',
'POESY',
'POILU',
'POINT',
'POISE',
'POKER',
'POLAR',
'POLIO',
'POLIT',
'POLKA',
'POLYP',
'POOCH',
'POPPY',
'PORCH',
'POSER',
'POSIT',
'POSSE',
'POUCH',
'POULT',
'POUND',
'POWER',
'PRANK',
'PRATE',
'PRAWN',
'PREEN',
'PRESS',
'PRICE',
'PRICK',
'PRIDE',
'PRIME',
'PRIMP',
'PRINK',
'PRINT',
'PRIOR',
'PRISM',
'PRIVY',
'PRIZE',
'PROBE',
'PROEM',
'PRONE',
'PRONG',
'PROOF',
'PROSE',
'PROSY',
'PROUD',
'PROVE',
'PROWL',
'PROXY',
'PRUDE',
'PRUNE',
'PSALM',
'PSEUD',
'PSYCH',
'PUBES',
'PUBIC',
'PUBIS',
'PUDGY',
'PUKKA',
'PULSE',
'PUNCH',
'PUPIL',
'PUPPY',
'PUREE',
'PURGE',
'PURIM',
'PURSE',
'PUSHY',
'PUSSY',
'PUTTY',
'PYGMY',
'PYLON',
'QUACK',
'QUAFF',
'QUAIL',
'QUAKE',
'QUALM',
'QUART',
'QUASH',
'QUASI',
'QUEAN',
'QUEEN',
'QUEER',
'QUELL',
'QUERY',
'QUEST',
'QUEUE',
'QUICK',
'QUIET',
'QUILL',
'QUILT',
'QUINT',
'QUIRE',
'QUIRK',
'QUIRT',
'QUITE',
'QUITS',
'QUOIT',
'QUOTA',
'QUOTE',
'QUOTH',
'QURSH',
'RABBI',
'RABID',
'RADAR',
'RADII',
'RADIO',
'RADON',
'RAISE',
'RALLY',
'RAMIE',
'RANCH',
'RANGE',
'RANGY',
'RAPID',
'RATIO',
'RATTY',
'RAVEL',
'RAVEN',
'RAYON',
'RAZOR',
'REACH',
'REACT',
'READY',
'REALM',
'REBEL',
'REBUS',
'REBUT',
'RECAP',
'RECIP',
'RECTO',
'RECUR',
'REEVE',
'REFER',
'REGAL',
'REIGN',
'RELAX',
'RELAY',
'RELIC',
'RELIG',
'REMIT',
'RENAL',
'RENEW',
'REPAY',
'REPEL',
'REPLY',
'RERUN',
'RESIN',
'RETCH',
'REVEL',
'REVUE',
'RHEUM',
'RHINO',
'RHYME',
'RIDER',
'RIDGE',
'RIFLE',
'RIGHT',
'RIGID',
'RIGOR',
'RINSE',
'RIPEN',
'RISER',
'RIVAL',
'RIVER',
'RIVET',
'RIYAL',
'RNZAF',
'ROACH',
'ROAST',
'ROBIN',
'ROBOT',
'RODEO',
'ROGER',
'ROGUE',
'ROMAN',
'ROOST',
'ROSIN',
'ROTOR',
'ROUGE',
'ROUGH',
'ROUND',
'ROUSE',
'ROUTE',
'ROWDY',
'ROWEL',
'ROYAL',
'RUBLE',
'RUDDY',
'RUGBY',
'RULER',
'RUMBA',
'RUMMY',
'RUMOR',
'RUNNY',
'RUPEE',
'RURAL',
'SABER',
'SABLE',
'SAINT',
'SALAD',
'SALLY',
'SALON',
'SALVE',
'SALVO',
'SANIT',
'SAPPY',
'SASSY',
'SATAN',
'SATIN',
'SATYR',
'SAUCE',
'SAUCY',
'SAUNA',
'SAUTE',
'SAVOR',
'SAVVY',
'SCALD',
'SCALE',
'SCALP',
'SCAMP',
'SCAND',
'SCANT',
'SCARE',
'SCARF',
'SCARP',
'SCENE',
'SCENT',
'SCION',
'SCOFF',
'SCOLD',
'SCONE',
'SCOOP',
'SCOOT',
'SCOPE',
'SCORE',
'SCORN',
'SCOTS',
'SCOUR',
'SCOUT',
'SCOWL',
'SCRAM',
'SCRAP',
'SCREW',
'SCRIM',
'SCRIP',
'SCROD',
'SCRUB',
'SCUBA',
'SCUFF',
'SCULL',
'SCURF',
'SEAMY',
'SEATO',
'SEDAN',
'SEDGE',
'SEEDY',
'SEINE',
'SEISM',
'SEIZE',
'SEMEN',
'SENGI',
'SENNA',
'SENSE',
'SENTI',
'SEPAL',
'SEPIA',
'SERGE',
'SERUM',
'SERVE',
'SERVO',
'SETUP',
'SEVEN',
'SEVER',
'SEWER',
'SHACK',
'SHADE',
'SHAFT',
'SHAKE',
'SHAKY',
'SHALE',
'SHALL',
'SHAME',
'SHANK',
'SHAPE',
'SHARD',
'SHARE',
'SHARK',
'SHARP',
'SHAVE',
'SHAWL',
'SHEAF',
'SHEAR',
'SHEEN',
'SHEEP',
'SHEER',
'SHEET',
'SHELF',
'SHELL',
'SHIER',
'SHIFT',
'SHILL',
'SHINE',
'SHINY',
'SHIPT',
'SHIRE',
'SHIRK',
'SHIRR',
'SHIRT',
'SHOAL',
'SHOAT',
'SHOCK',
'SHONE',
'SHOOK',
'SHOOT',
'SHORE',
'SHORN',
'SHORT',
'SHOUT',
'SHOVE',
'SHOWY',
'SHRED',
'SHREW',
'SHRUB',
'SHRUG',
'SHUCK',
'SHUNT',
'SIBYL',
'SIDLE',
'SIEGE',
'SIEVE',
'SIGHT',
'SILLY',
'SINCE',
'SINEW',
'SINGE',
'SINUS',
'SIOUX',
'SIREN',
'SIRUP',
'SISAL',
'SISSY',
'SITAR',
'SIXTY',
'SKATE',
'SKEET',
'SKEIN',
'SKIFF',
'SKILL',
'SKIMP',
'SKIRT',
'SKULK',
'SKULL',
'SKUNK',
'SLACK',
'SLAIN',
'SLAKE',
'SLANG',
'SLANT',
'SLASH',
'SLATE',
'SLAVE',
'SLEEK',
'SLEEP',
'SLEET',
'SLICE',
'SLICK',
'SLIDE',
'SLIER',
'SLIME',
'SLING',
'SLINK',
'SLOOP',
'SLOPE',
'SLOSH',
'SLOTH',
'SLUMP',
'SLUNG',
'SLUNK',
'SLURP',
'SLUSH',
'SMACK',
'SMALL',
'SMART',
'SMASH',
'SMEAR',
'SMELL',
'SMELT',
'SMILE',
'SMIRK',
'SMITE',
'SMITH',
'SMOCK',
'SMOKE',
'SMOTE',
'SMSGT',
'SNACK',
'SNAIL',
'SNAKE',
'SNARE',
'SNARL',
'SNEAK',
'SNEER',
'SNIDE',
'SNIFF',
'SNIPE',
'SNIPS',
'SNOOP',
'SNORE',
'SNORT',
'SNOUT',
'SNOWY',
'SNUCK',
'SNUFF',
'SOBER',
'SOGGY',
'SOLAR',
'SOLID',
'SOLON',
'SOLVE',
'SONAR',
'SONIC',
'SOOTH',
'SORRY',
'SOUGH',
'SOUND',
'SOUPY',
'SOUSE',
'SOUTH',
'SPACE',
'SPADE',
'SPANK',
'SPARE',
'SPARK',
'SPASM',
'SPATE',
'SPAWN',
'SPEAK',
'SPEAR',
'SPECK',
'SPEED',
'SPELL',
'SPEND',
'SPENT',
'SPERM',
'SPICE',
'SPIEL',
'SPIKE',
'SPILL',
'SPINE',
'SPIRE',
'SPIRT',
'SPITE',
'SPLAY',
'SPLIT',
'SPOIL',
'SPOKE',
'SPOOF',
'SPOOK',
'SPOOL',
'SPOON',
'SPOOR',
'SPORE',
'SPORT',
'SPOUT',
'SPRAT',
'SPRAY',
'SPREE',
'SPRIG',
'SPUME',
'SPUNK',
'SPURN',
'SPURT',
'SQUAB',
'SQUAD',
'SQUAT',
'SQUAW',
'SQUIB',
'SQUID',
'STACK',
'STAFF',
'STAGE',
'STAID',
'STAIN',
'STAIR',
'STAKE',
'STALE',
'STALK',
'STALL',
'STAMP',
'STAND',
'STANK',
'STARE',
'STARK',
'START',
'STASH',
'STATE',
'STAVE',
'STEAD',
'STEAK',
'STEAL',
'STEAM',
'STEED',
'STEEL',
'STEEP',
'STEER',
'STEIN',
'STERE',
'STERN',
'STICK',
'STIFF',
'STILE',
'STILL',
'STILT',
'STING',
'STINK',
'STINT',
'STOAT',
'STOCK',
'STOIC',
'STOKE',
'STOLE',
'STOMP',
'STONE',
'STOOD',
'STOOL',
'STOOP',
'STORE',
'STORK',
'STORM',
'STORY',
'STOUT',
'STOVE',
'STRAP',
'STRAW',
'STRAY',
'STREW',
'STRIA',
'STRIP',
'STROP',
'STRUM',
'STRUT',
'STUCK',
'STUDY',
'STUFF',
'STUMP',
'STUNG',
'STUNK',
'STUNT',
'STYLE',
'SUAVE',
'SUCRE',
'SUEDE',
'SUGAR',
'SUITE',
'SULFA',
'SULKY',
'SULLY',
'SUMAC',
'SUNUP',
'SUPER',
'SUPRA',
'SUPVR',
'SURGE',
'SURLY',
'SWAGE',
'SWAIN',
'SWAMI',
'SWAMP',
'SWANK',
'SWARD',
'SWARM',
'SWART',
'SWASH',
'SWATH',
'SWEAR',
'SWEAT',
'SWEDE',
'SWEEP',
'SWEET',
'SWELL',
'SWEPT',
'SWIFT',
'SWILL',
'SWINE',
'SWING',
'SWIPE',
'SWIRL',
'SWISH',
'SWISS',
'SWITZ',
'SWOON',
'SWOOP',
'SWORD',
'SWORE',
'SWORN',
'SWUNG',
'SYLPH',
'SYNOD',
'SYRUP',
'TABBY',
'TABLE',
'TABOO',
'TABOR',
'TACIT',
'TACKY',
'TAFFY',
'TAIGA',
'TAINT',
'TALER',
'TALLY',
'TALON',
'TALUS',
'TANGO',
'TANSY',
'TAPER',
'TAPIR',
'TARDY',
'TAROT',
'TARRY',
'TASTE',
'TASTY',
'TAUNT',
'TAUPE',
'TAWNY',
'TEACH',
'TEASE',
'TEENS',
'TEENY',
'TEETH',
'TELEG',
'TEMPO',
'TEMPT',
'TENET',
'TENON',
'TENOR',
'TENSE',
'TEPEE',
'TEPID',
'TERRY',
'TERSE',
'TESTY',
'THANE',
'THANK',
'THEAT',
'THEFT',
'THEGN',
'THEIR',
'THEME',
'THEOL',
'THERE',
'THERM',
'THESE',
'THESS',
'THICK',
'THIEF',
'THIGH',
'THINE',
'THING',
'THINK',
'THIRD',
'THOLE',
'THONG',
'THORN',
'THORP',
'THOSE',
'THREE',
'THREW',
'THROB',
'THROE',
'THROW',
'THRUM',
'THUMB',
'THUMP',
'THURS',
'THYME',
'TIARA',
'TIBIA',
'TICAL',
'TIGER',
'TIGHT',
'TILDE',
'TILTH',
'TIMES',
'TIMID',
'TINCT',
'TINGE',
'TINNY',
'TIPSY',
'TIRED',
'TITAN',
'TITHE',
'TITLE',
'TIZZY',
'TOADY',
'TOAST',
'TODAY',
'TODDY',
'TOKAY',
'TOKEN',
'TONGS',
'TONIC',
'TOOTH',
'TOPAZ',
'TOPER',
'TOPIC',
'TOPOG',
'TOQUE',
'TORAH',
'TORCH',
'TORSO',
'TOTAL',
'TOTEM',
'TOUCH',
'TOUGH',
'TOWEL',
'TOWER',
'TOXIC',
'TOXIN',
'TRACE',
'TRACK',
'TRACT',
'TRADE',
'TRAIL',
'TRAIN',
'TRAIT',
'TRAMP',
'TRANS',
'TRAPS',
'TRASH',
'TRAWL',
'TREAD',
'TREAS',
'TREAT',
'TREND',
'TRESS',
'TRIAD',
'TRIAL',
'TRIBE',
'TRICE',
'TRICK',
'TRIED',
'TRILL',
'TRINE',
'TRIPE',
'TRITE',
'TROLL',
'TROMP',
'TROOP',
'TROPE',
'TROTH',
'TROUT',
'TRUCE',
'TRUCK',
'TRUMP',
'TRUNK',
'TRUSS',
'TRUST',
'TRUTH',
'TRYST',
'TUBER',
'TULIP',
'TULLE',
'TUMID',
'TUMMY',
'TUMOR',
'TUNIC',
'TUNNY',
'TUQUE',
'TURPS',
'TUTOR',
'TWAIN',
'TWANG',
'TWEAK',
'TWEED',
'TWEEN',
'TWEET',
'TWICE',
'TWILL',
'TWINE',
'TWIRL',
'TWIST',
'TWIXT',
'TYING',
'UDDER',
'IKASE',
'ULCER',
'ULTRA',
'UMBEL',
'UMBER',
'UMBRA',
'UMIAK',
'UNARM',
'UNBAR',
'UNCAP',
'UNCLE',
'UNCUT',
'UNDER',
'UNDUE',
'UNFIT',
'UNFIX',
'UNIFY',
'UNION',
'UNITE',
'UNITY',
'UNMAN',
'UNPEG',
'UNPIN',
'UNRWA',
'UNSAY',
'UNTIE',
'UNTIL',
'UNZIP',
'UPEND',
'UPPER',
'UPSET',
'URBAN',
'URINE',
'USAGE',
'USHER',
'USUAL',
'USURP',
'USURY',
'UTILE',
'UTTER',
'UVULA',
'VAGUE',
'VALET',
'VALID',
'VALOR',
'VALSE',
'VALUE',
'VALVE',
'VAPID',
'VAPOR',
'VARIA',
'VASTY',
'VATIC',
'VAULT',
'VAUNT',
'VEERY',
'VELAR',
'VELUM',
'VENAL',
'VENOM',
'VENUE',
'VENUS',
'VERGE',
'VERSE',
'VERSO',
'VERST',
'VERVE',
'VETCH',
'VIAND',
'VIBES',
'VICAR',
'VIDEO',
'VIGIL',
'VIGOR',
'VILLA',
'VINYL',
'VIOLA',
'VIPER',
'VIRAL',
'VIREO',
'VIRTU',
'VIRUS',
'VISIT',
'VISOR',
'VISTA',
'VITAL',
'VIVID',
'VIXEN',
'VIZOR',
'VOCAB',
'VOCAL',
'VODKA',
'VOGUE',
'VOICE',
'VOILE',
'VOMIT',
'VOUCH',
'VOWEL',
'VULVA',
'VYING',
'WACKY',
'WADER',
'WAFER',
'WAGER',
'WAGON',
'WAHOO',
'WAIST',
'WAIVE',
'WAKEN',
'WALTZ',
'WASHY',
'WASTE',
'WATCH',
'WATER',
'WAVER',
'WAXEN',
'WEALD',
'WEARY',
'WEAVE',
'WEDGE',
'WEEDY',
'WEENY',
'WEEPY',
'WEIGH',
'WEIRD',
'WELCH',
'WELSH',
'WENCH',
'WHACK',
'WHALE',
'WHARF',
'WHEAL',
'WHEAT',
'WHEEL',
'WHELK',
'WHELM',
'WHELP',
'WHERE',
'WHICH',
'WHIFF',
'WHILE',
'WHINE',
'WHIRL',
'WHISH',
'WHISK',
'WHIST',
'WHITE',
'WHOLE',
'WHOOP',
'WHORE',
'WHORL',
'WHOSE',
'WHOSO',
'WHSLE',
'WIDEN',
'WIDOW',
'WIDTH',
'WIELD',
'WIGHT',
'WINCE',
'WINCH',
'WINDY',
'WITCH',
'WITHE',
'WITHY',
'WITTY',
'WIVES',
'WOKEN',
'WOMAN',
'WOODY',
'WOOZY',
'WORDY',
'WORLD',
'WORRY',
'WORSE',
'WORST',
'WORTH',
'WOULD',
'WOUND',
'WOVEN',
'WRACK',
'WRATH',
'WREAK',
'WRECK',
'WREST',
'WRING',
'WRIST',
'WRITE',
'WRONG',
'WROTE',
'WROTH',
'WRUNG',
'WURST',
'XEBEC',
'XENON',
'XERIC',
'XYLEM',
'YACHT',
'YAHOO',
'YEARN',
'YEAST',
'YIELD',
'YODEL',
'YOKEL',
'YOUNG',
'YOURS',
'YOUTH',
'YUCCA',
'YUMMY',
'ZAIRE',
'ZEBRA',
'ZIPPY',
'ZLOTY',
'ZONAL'
]).
