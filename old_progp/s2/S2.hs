import Data.List.Split

dansk s = en2ni (splitOn " " s)

en2ni (h:t)
	| h == "en"	= 1 + mer t
	| h == "to"	= 2 + mer t
	| h == "tre"	= 3 + mer t
	| h == "fire"	= 4 + mer t
	| h == "fem"	= 5 + mer t
	| h == "seks"	= 6 + mer t
	| h == "syv"	= 7 + mer t
	| h == "otte"	= 8 + mer t
	| h == "ni"	= 9 + mer t
	| otherwise = ti2nitten (h:t)

ti2nitten (h:t)
	| h == "ti"		= 10
	| h == "ellve"		= 11
	| h == "tolv"		= 12
	| h == "tretten"	= 13
	| h == "fjorten"	= 14
	| h == "femten"		= 15
	| h == "seksten"	= 16
	| h == "sytten" 	= 17
	| h == "atten"		= 18
	| h == "nitten"		= 19
	| h == "hundrede"	= 100
	| otherwise = tyve2halvfems (h:t)

mer [] = 0
mer (h:t)
	| h == "og"	= tyve2halvfems t	--(+ tiotal t, 20 ≤ t ≤ 90)
	| otherwise	= error "fel"		--( 0, dvs enbart en2ni)

tyve2halvfems (h:t)
	| h == "tyve"		= 20
	| h == "tredive"	= 30
	| h == "fyrre"		= 40
	| h == "fyrretyve"	= 40
	| otherwise = halvtreds2halvfems (emfas (h:t))	--(tiotal t, 50 ≤ t ≤ 90)

halvtreds2halvfems (h:t)
	| h == "halv"	= -10 + mult t
	| otherwise	= mult (h:t)

mult (h:t)
	| h == "tres"		= 60
	| h == "firs"		= 80
	| h == "fjerds"		= 80
	| h == "fems"		= 100
	| otherwise		= error "fel"

emfas (h:t)
	| h == "sindtyve"	= t		--(× 20)
	| otherwise		= (h:t)		--(× 20)

test = do
	text <- readFile "dr.txt"
	return $ map dansk $ filter (\x -> x /="") (lines text)

