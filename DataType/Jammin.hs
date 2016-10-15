{-# OPTIONS_GHC -Wall #-}

module Jammin where

import Data.List

data Fruit = Peach | Plum | Apple | Blackberry deriving (Ord, Eq, Show)

data JamJars = Jam {
  fruit :: Fruit,
  stock :: Int
} deriving (Ord, Eq, Show)

row1 :: JamJars
row1 = Jam Peach 10
row2 :: JamJars
row2 = Jam Plum 20
row3 :: JamJars
row3 = Jam Apple 1
row4 :: JamJars
row4 = Jam Blackberry 5
row5 :: JamJars
row5 = Jam Apple 20
allJam :: [JamJars]
allJam = [row1,row2,row3,row4,row5]

totalStock :: [JamJars] -> Int
totalStock = sum . (map stock)

mostRow :: [JamJars] -> JamJars
mostRow [] = error "empty List"
mostRow (x:xs) = foldr (\a acc -> if stock a > stock acc then a else acc) x xs

sortJam :: [JamJars] -> [JamJars]
sortJam [] = []
sortJam xs = sortBy compareKind xs
  where compareKind (Jam k _) (Jam k' _) = compare k k'

groupJam :: [JamJars] -> [[JamJars]]
groupJam [] = []
groupJam xs = groupBy f (sortJam xs)
    where f (Jam k _) (Jam k' _) = k == k'

totalStockByGroup :: [[JamJars]] -> [Int]
totalStockByGroup [] = []
totalStockByGroup xs = map totalStock xs
