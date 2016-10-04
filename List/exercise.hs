{-# OPTIONS_GHC -Wall #-}

eftChar :: Char -> Char -> [Char]
eftChar x y = go x y []

eftBool :: Bool -> Bool -> [Bool]
eftBool x y = go x y []

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd x y = go x y []

eftInt :: Int -> Int -> [Int]
eftInt x y = go x y []

go :: (Ord a,Enum a) => a -> a -> [a] -> [a]
go x' y' acc
  | x' > y' = acc
  | x' == y' = acc ++ [x']
  | otherwise = go (succ x') y' (acc ++ [x'])
