module Profile where
import Data.List
import MolSeq

data Profile = Profile {profileMatrix :: [[(Char, Int)]], profileName :: String, numSequences :: Int, profType :: SeqType} deriving (Show)

nucleotides = "ACGT"
aminoacids = sort "ARNDCEQGHILKMFPSTWYVX"

fromMolSeqs :: [MolSeq] -> Profile
fromMolSeqs [] = error "Empty sequence list"
fromMolSeqs (molseq:molseqs) = Profile (makeProfileMatrix (molseq:molseqs)) (seqName molseq) (length (molseq:molseqs)) (seqType molseq)		

profileDistance :: Profile -> Profile -> Float
profileDistance p1 p2 = (matrixDistance (profileMatrix p1) (profileMatrix p2))
        where
        matrixDistance :: [[(Char, Int)]] -> [[(Char, Int)]] -> Float
        matrixDistance [] [] = 0
        matrixDistance (mh1:mt1) (mh2:mt2) = (listDistance mh1 mh2) + (matrixDistance mt1 mt2)
                where
                listDistance :: [(Char, Int)] -> [(Char, Int)] -> Float
                listDistance [] [] = 0
                listDistance (lh1:lt1) (lh2:lt2) = (pairDistance lh1 lh2) + (listDistance lt1 lt2)
                        where
                        pairDistance :: (Char, Int) -> (Char, Int) -> Float
                        pairDistance (ph1,pt1) (ph2,pt2) = abs((fromIntegral pt1/fromIntegral(numSequences p1)) - (fromIntegral pt2/fromIntegral(numSequences p2)))
						

makeProfileMatrix :: [MolSeq] -> [[(Char, Int)]]
makeProfileMatrix [] = error "Empty sequence list"
makeProfileMatrix sl = res
  where 
    t = seqType (head sl)
    n = length sl
    defaults = if (t == DNA) then
                 zip nucleotides (replicate (length nucleotides) 0) -- Rad (i)
               else 
                 zip aminoacids (replicate (length aminoacids) 0)   -- Rad (ii)
    strs = map seqSequence sl                                       -- Rad (iii)
    tmp1 = map (map (\x -> ((head x), (length x))) .group .sort)  -- Rad (iv)
               (transpose strs)
    equalFst a b = (fst a ) == (fst b)
    res = map sort (map (\l -> unionBy equalFst l defaults) tmp1)






