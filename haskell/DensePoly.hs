module DensePoly() where
import PolyClass
import Representation
import Data.List


-- instance Functor DensePoly where
--     fmap f (P pList)        = P (f pList)

instance Polynomial DensePoly where
    zeroP  = P []
    constP a 
        | a == 0 = zeroP
        | otherwise = P [a]
    varP = P [0, 1]
    evalP (P pList) x = evalPAcc x (reverse pList) 0
        where evalPAcc x pList acc = case pList of
                [] -> acc
                pHead : pTail -> evalPAcc x pTail (acc * x + pHead)

    shiftP n (P pList) 
        | pList == [] || n == 0 = (P pList)
        | otherwise = shiftP (n-1) (P (shiftOne pList))
                                where shiftOne list = 0 : list
    degree (P pList) = length(pList) - 1

simplify :: (Eq a, Num a) => [a] -> [a]
simplify l = reverse(dropWhile (0 ==) (reverse l))

add ::  (Eq a, Num a) => [a] -> [a] -> [a]
add [] b = b
add a b | (length a) > (length b) = add b a
add (ah : at) (bh : bt) = (ah + bh) : (add at bt) 

mulConst ::  (Eq a, Num a) => a -> [a] -> [a]
mulConst a b  = map (\y -> (y*a)) b

mul :: (Eq a, Num a) => [a] -> [a] -> [a]
mul a b =
    case (a, b) of
        ([], _) -> []
        ((ah : at), b) -> add (mulConst ah b) l
            where P l = (shiftP 1 (P (mul at b)))

instance (Eq a, Num a) => Num (DensePoly a) where
    (P a) + (P b) = P (simplify (add a b))
    (P a) - (P b) = (P a) + (negate (P b))
    (P a) * (P b) = P (simplify (mul a b))
    negate (P a) = (constP (-1)) * (P a)
    abs = undefined
    signum = undefined
    fromInteger i = constP (fromInteger i)


-- |
-- >>> let x = varP :: DensePoly Integer in x^3 - 1
-- P {unP = [-1,0,0,1]}
instance (Eq a, Num a) => Eq (DensePoly a) where
   P list1 == P list2  =  (simplify list1 == simplify list2) 


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
