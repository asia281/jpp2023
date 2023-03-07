module DensePoly() where
import PolyClass
import Representation
import Data.List


-- instance Functor DensePoly where
--     fmap f (P pList)        = P (f pList)

instance Polynomial DensePoly where
    zeroP  = P []
    constP a = P [a]
    varP = P [0, 1]
    evalP (P pList) x = evalPAcc x pList 0
        where evalPAcc x pList acc = case pList of
                [] -> acc
                pHead : pTail -> evalPAcc x pTail (acc * x + pHead)

    shiftP n zeroP = zeroP
    shiftP n (P pList) = 
        case n of
            0 -> (P pList)
            _ -> shiftP (n-1) (P (shiftOne pList))
                where shiftOne list = 0 : list
    degree (P pList) = length(pList) - 1

simplify :: (Eq a, Num a) => [a] -> [a] -> [a]
simplify l acc = 
        case l of
            [] -> reverse acc
            h : t | h == 0 && acc == [] -> simplify t acc
            h : t -> simplify t (h : acc)

add ::  (Eq a, Num a) => [a] -> [a] -> [a]
add [] b = b
add a b | (length a) > (length b) = add b a
add (ah : at) (bh : bt) = (ah + bh) : (add at bt) 

addAndSimplify ::  (Eq a, Num a) => [a] -> [a] -> [a]
addAndSimplify a b = simplify (reverse (add a b)) []

mulConst ::  (Eq a, Num a) => a -> [a] -> [a] -> [a]
mulConst a b acc = 
    case b of
        [] -> reverse acc
        bh : bt -> mulConst a bt ((a * bh) : acc)

mul :: (Eq a, Num a) => [a] -> [a] -> [a]
mul a b =
    case (a, b) of
        ([], _) -> []
        ((ah : at), b) -> addAndSimplify (mulConst ah (reverse b) []) (shiftP 1 (P (mul at b)))

mulAndSimplify :: (Eq a, Num a) => [a] -> [a] -> [a]
mulAndSimplify a b = simplify (reverse (mul a b)) []

instance (Eq a, Num a) => Num (DensePoly a) where
    (P a) + (P b) = P (addAndSimplify a b)
    (P a) - (P b) = (P a) + (negate (P b))
    (P a) * (P b) = P (mulAndSimplify a b)
    negate (P a) = (constP (-1)) * (P a)
    abs = undefined
    signum = undefined
    fromInteger i = 
        case i of
            0 -> zeroP
            _ -> constP (fromInteger i)


-- |
-- >>> let x = varP :: DensePoly Integer in x^3 - 1
-- P {unP = [-1,0,0,1]}
instance (Eq a, Num a) => Eq (DensePoly a) where
   P list1 == P list2  =  list1 == list2


-- |
-- >>>  P [1,2] == P [1,2]
-- True

-- |
-- >>> fromInteger 0 == (zeroP :: DensePoly Int)
-- True

-- |
-- >>>  P [0,1] == P [1,0]
-- False

-- | Degree examples
-- >>> degree (zeroP :: DensePoly Int)
-- -1
-- >>> degree (constP 1 :: DensePoly Int)
-- 0
