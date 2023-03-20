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
            pHead : pTail | pHead /= 0 -> createSP (P pTail) (cnt+1) ((cnt, pHead):acc)
            pHead : pTail -> createSP (P pTail) (cnt+1) acc

appendZeros :: (Eq a, Num a) => Int -> Int -> a -> [a] -> [a]
appendZeros prev curr toAdd acc 
    | prev == curr = acc
    | prev < 0 || prev-1 == curr  = toAdd:acc
    | otherwise = appendZeros (prev-1) curr toAdd (0:acc)

toDP (S sList) 
    | sList == []  = (P [])
    | otherwise = P (createDP (S sList) (-1) []) 
    where createDP (S sList) prev acc = case sList of
            [] -> (appendZeros prev 0 0 acc)
            (sExp, sNum) : sTail -> createDP (S sTail) sExp (appendZeros prev sExp sNum acc)

first :: (a -> a') -> (a, b) -> (a', b)
first f (a, b) = ((f a), b)
second :: (b -> b') -> (a, b) -> (a, b')
second f (a, b) = (a, (f b))

instance Functor SparsePoly where
    fmap f (S ncs) = S ((second f) <$> ncs)

fastPow :: (Num a) => a -> Int -> a
fastPow base 1 = base
fastPow base pow | even pow = (fastPow base (div pow 2)) ^ 2
                 | odd pow = (fastPow base (div (pow-1) 2)) ^ 2 * base

instance Polynomial SparsePoly where
    zeroP  = S []
    constP a 
        | a == 0 = zeroP
        | otherwise = S [(0, a)]
    varP = S [(1, 1)]
    evalP (S sList) n = foldl (\x (yExp, yVar) -> (x + yVar * (fastPow n yExp))) 0 sList    

    degree (S sList) = case sList of
        [] -> -1
        sHead : _ -> (fst sHead)
        
    shiftP n (S sList) = S (map (\y -> (first (\x -> n+x) y)) sList)

simplify :: (Eq a, Num a) => [(Int, a)] -> [(Int, a)]
simplify l = filter (\x -> (snd x) /= 0 ) l 

add ::  (Eq a, Num a) => [(Int, a)] -> [(Int, a)] -> [(Int, a)]
add a [] = a
add [] b = b
add (ah : at) (bh : bt) | (fst ah) == (fst bh) = ((fst ah), ((snd ah) + (snd bh))) : (add at bt) 
add (ah : at) (bh : bt) | (fst ah) > (fst bh) = ah : (add at (bh : bt)) 
add a b = add b a

mulConst ::  (Eq a, Num a) => (Int, a) -> [(Int, a)] -> [(Int, a)]
mulConst (aExp, aVar) b  = map (\(x, y) -> (x + aExp, y * aVar)) b

mul :: (Eq a, Num a) => [(Int, a)] -> [(Int, a)] -> [(Int, a)]
mul a b =
    case (a, b) of
        ([], _) -> []
        ((ah : at), b) -> add (mulConst ah b) (mul at b)


instance (Eq a, Num a) => Num (SparsePoly a) where
    (S a) + (S b) = S (simplify (add a b))
    (S a) - (S b) = (S a) + (negate (S b))
    (S a) * (S b) = S (simplify (mul a b))
    negate (S sList) = (constP (-1)) * (S sList)
    abs = undefined
    signum = undefined
    fromInteger i = constP (fromInteger i)

instance (Eq a, Num a) => Eq (SparsePoly a) where
    S list1 == S list2 = list1 == list2

getFirstElem :: (Num a) => SparsePoly a -> a
getFirstElem (S sList) = 
    case sList of
        [] -> 1
        sHead : _ -> (snd sHead)

-- qrP s t | not(nullP t) = (q, r) iff s == q*t + r && degree r < degree t
qrP :: (Eq a, Fractional a) => SparsePoly a -> SparsePoly a -> (SparsePoly a, SparsePoly a)
qrP s t = divWithRes s t zeroP
    where divWithRes f s q | ddif < 0 = (q, f)
                           | otherwise = divWithRes f' s q'
                                where 
                                    ddif = (degree f) - (degree s)
                                    k = constP ((getFirstElem f) / (getFirstElem s))
                                    q' = q + (shiftP ddif k)
                                    f' = f - (k * (shiftP ddif s))


-- | Division example
-- >>> let x = varP in qrP (x^2 - 1) (x -1) == ((x + 1), 0)
-- True
