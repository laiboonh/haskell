{-# OPTIONS_GHC -Wall #-}

-- To find out if lists in list is all same length
sameLength :: [[a]] -> Bool
sameLength [] = False
sameLength (x:xs) = foldl step True xs
  where
    headLen = length x
    step acc e = acc && (length e == headLen)

f :: (a,b,c) -> (d,e,f) -> ((a,d),(c,f))
f (a',_,c') (d',_,f') = ((a',d'),(c',f'))

dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10

oneIsOne :: Num a => a -> a
oneIsOne = dodgy 1

oneIsTwo :: Num a => a -> a
oneIsTwo = (flip dodgy) 2

data Doggies a = Husky a | Mastiff a deriving (Eq, Show)
data DogueDeBordeaux doge = DogueDeBordeaux doge
