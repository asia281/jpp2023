module SparsePoly(fromDP, toDP, qrP) where
import PolyClass
import Representation

-- | fromDP example
-- >>> fromDP sampleDP
-- S {unS = [(3,1),(0,-1)]}
fromDP :: (Eq a, Num a) => DensePoly a -> SparsePoly a
toDP :: (Eq a, Num a) => SparsePoly a -> DensePoly a


fromDP (P pList) = S (createSP (P pList) 0 [])
    where createSP (P pList) cnt acc = case pList of
            [] -> acc
            pHead : pTail -> createSP (P pTail) (cnt+1) ((cnt, pHead):acc)

appendZeros :: Int -> Int -> a -> [a] -> [a]
appendZeros prev curr toAdd acc | prev < 0 = toAdd:acc
appendZeros prev curr toAdd acc | prev - 1 == curr  = toAdd:acc
appendZeros prev curr toAdd acc = appendZeros (prev+1) curr toAdd (0:acc)


toDP (S sList) = P (createDP (S sList) (-2) [])
    where createDP (S sList) prev acc = case sList of
            [] -> acc
            (sExp, sNum) : sTail -> createDP (S sTail) sExp (appendZeros prev sExp sNum acc)

first :: (a -> a') -> (a, b) -> (a', b)
first f (a, b) = ((f a), b)
second :: (b -> b') -> (a, b) -> (a, b')
second f (a, b) = (a, (f b))

-- instance Functor SparsePoly where

instance Polynomial SparsePoly where
    zeroP  = S []
    constP a = S [(0, a)]
    varP = S [(1, 1)]
    evalP (S sList) x = evalP (toDP (S sList)) x

    shiftP n zeroP = zeroP
    shiftP n (S sList) = 
        case n of
            0 -> (S sList)
            _ -> shiftP (n-1) (S (shiftOne sList))
                where shiftOne list = 0 : list
    degree (S sList) = length(sList) - 1

instance (Eq a, Num a) => Num (SparsePoly a) where
    negate (S sList) = (constP (-1)) * (S sList)
    abs = undefined
    signum = undefined
    fromInteger i = 
        case i of
            0 -> zeroP
            _ -> constP (fromInteger i)

instance (Eq a, Num a) => Eq (SparsePoly a) where
    p == q = nullP(p-q)

-- qrP s t | not(nullP t) = (q, r) iff s == q*t + r && degree r < degree t
qrP :: (Eq a, Fractional a) => SparsePoly a -> SparsePoly a -> (SparsePoly a, SparsePoly a)
qrP = undefined

-- | Division example
-- >>> let x = varP in qrP (x^2 - 1) (x -1) == ((x + 1), 0)
-- True
