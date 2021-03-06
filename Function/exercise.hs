{-# OPTIONS_GHC -Wall #-}

{-
mTh x y z = x * y * z

mTh' x y = \z -> x * y * z

mTh'' x = \y -> \z -> x * y * z

mTh''' = \x -> \y -> \z -> x * y * z

addOneIfTrue :: Int -> Int
addOneIfTrue = \n -> case odd n of
  True  -> f n
  False -> n
  where f n = n + 1

addFive :: (Num a, Ord a) => a -> a -> a
addFive = \x -> \y -> (if x > y then y else x) + 5

mflip :: (b -> a -> a) -> a -> b -> a
mflip f x y = f y x
-}

functionC :: Ord a => a -> a -> a
functionC x y = case (x > y) of
  True  -> x
  False -> y

ifEvenAdd2 :: Integral a => a -> a
ifEvenAdd2 n = case (even n) of
  True  -> n + 2
  False -> n

num :: (Ord a, Num a) => a -> a
num x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    _  -> 0

foldBool :: a -> a -> Bool -> a
foldBool x y b
  | b == True = x
  | otherwise = y

foldBool' :: a -> a -> Bool -> a
foldBool' x y b = case b of
  True  -> x
  False -> y

tenDigit :: Integral a => a -> a
tenDigit x = m
    where dm = x `divMod` 100
          m = snd dm

g :: (a->b) -> (a,c) -> (b,c)
g f (a,c) = (f a,c)

roundTrip :: (Show a, Read b) => a -> b
roundTrip a = read . show $ a

cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"

frappe :: String -> String
frappe = flippy "haha"

mySum :: (Eq a, Num a) => a -> a
mySum x = go x 0
  where go :: (Eq a, Num a) => a -> a -> a
        go 0 acc = acc
        go x' acc = go (x' - 1) acc + x'

myMul :: (Integral a) => a -> a -> a
myMul x y = go x y 0
  where go :: (Integral a) => a -> a -> a -> a
        go x' y' acc
          | x' > 0 && y' > 0 = go x' (y' - 1) (acc + x')
          | x' < 0 && y' < 0 = go (-x') (-y') (acc)
          | x' > 0 && y' < 0 = go x' (y' + 1) (acc - x')
          | x' < 0 && y' > 0 = go x' (y' - 1) (acc + x')
          | otherwise = acc

mc91 :: (Ord a, Num a) => a -> a
mc91 x
  | x > 100 = x -10
  | otherwise = 91
