module Evol where
import MolSeq
import Profile

class Evol a where 
	distance :: a -> a -> (String, String, Float)
	
instance Evol Profile where
	distance a b = (profileName a, profileName b, profileDistance a b)

instance Evol MolSeq where
	distance a b = (seqName a, seqName b, seqDistance a b)
	
distanceMatrix :: (Evol a) => [a] -> [(String, String, Float)]
distanceMatrix [] = [] 
distanceMatrix evol = [distance a b | a <- evol, b <- evol ]