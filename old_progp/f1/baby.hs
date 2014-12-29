import Char
	
doubleMe x = x + x

doubleUs x y = x*2 + y*2

doubleSmallNumber x = if x > 100  
                        then x  
                        else x*2
						
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1  

conanO'Brien = "It's a-me, Conan O'Brien!"   

fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

isVowel x = if elem x "aeiouy"
			then True
			else False
isConsonant x = if isVowel x
			then False
			else True
rovarsprak "" = ""
rovarsprak (h:t) | isVowel h = h:rovarsprak t
				 | otherwise = h:'o':h:rovarsprak t
svenska "" = ""
svenska (h:t)	| isVowel h = h:svenska t
				| otherwise = h:svenska (drop 2 t)
				
maxord :: String -> Int
maxord "" = 0
maxord s  = maxordHelp s 0 0

maxordHelp :: String -> Int -> Int -> Int
maxordHelp "" l c = l
maxordHelp (h:t) l c | isAlpha h = maxordHelp t l (c+1)
                     | otherwise = maxordHelp t (max l c) 0

merge :: Ord a => [a] -> [a] -> [a]
merge c [] = c



merge [] d = d
merge (h1:t1) (h2:t2) | h1 < h2 = h1:(merge t1 (h2:t2))
                      | otherwise = h2:(merge (h1:t1) t2)
					  


ackfib 0 = 0
ackfib 1 = 1					  
ackfib n = count n
count :: Int -> Int
count n = loop 1 0 1
	where
		loop i f1 f2
			| i >= n = f2		
			| otherwise = loop (i+1) (f2) (f1 + f2)
			

--truefalse :: [Bool]
--truefalse = true:false:truefalse
