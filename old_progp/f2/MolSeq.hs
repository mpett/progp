module MolSeq where

data SeqType = DNA|Protein deriving (Show, Eq) 
data MolSeq = MolSeq {seqName :: String, seqSequence :: String, seqType :: SeqType}
					deriving (Show)

isDNA :: String -> Bool
isDNA [] = False
isDNA [x]	 | elem x "ATGC" = True
			 | otherwise = False
isDNA (x:xs) | elem x "ATGC" = isDNA xs
			 | otherwise = False

string2seq :: String -> String -> MolSeq
string2seq x y 	| isDNA y = MolSeq x y DNA
			| otherwise = MolSeq x y Protein

seqLength :: MolSeq -> Int
seqLength m = length (seqSequence m)

sequenceDifference :: String -> String -> Int
sequenceDifference "" "" = 0
sequenceDifference a b = sequenceCount a b 0

sequenceCount :: String -> String -> Int -> Int
sequenceCount "" "" counter = counter
sequenceCount (a1:a2) (b1:b2) counter	| a1 == b1 = sequenceCount a2 b2 counter
										| otherwise = sequenceCount a2 b2 (counter + 1)

alphaValue :: String -> String -> Float
alphaValue seq1 seq2 = fromIntegral(sequenceDifference seq1 seq2)/fromIntegral(length seq1)

seqDistance :: MolSeq -> MolSeq -> Float
seqDistance a b		| seqType a == DNA && seqType b == DNA = if alpha > 0.74
						then 3.3
						else -(3/4) * log (1 - 4 * alpha/3)
			| otherwise =    if alpha >= 0.94
						then 3.7
						else -(19/20) * log (1 - 20 * alpha/19)
				where alpha = alphaValue (seqSequence a) (seqSequence b)

conanO'Brien = "It'a a-me! Conan!"


										
