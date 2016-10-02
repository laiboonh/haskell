{-# OPTIONS_GHC -Wall #-}

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
