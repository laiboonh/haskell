{-# OPTIONS_GHC -Wall #-}

import Data.List

count :: [a] -> Integer
count (_:xs) = 1 + count xs
count []     = 0

count' :: Integer -> [a] -> Integer
count' acc (_:xs) = count' (acc + 1) xs
count' acc []     = acc

sumList :: (Fractional a) => [a] -> a
sumList [] = 0
sumList (x:xs) = x + (sumList xs)

lengthList :: (Fractional a) => [t] -> a
lengthList [] = 0
lengthList (_:xs) = 1 + (lengthList xs)

meanList :: (Fractional a) => [a] -> a
meanList xs = (sumList xs) / (lengthList xs)

reverseList :: [a] -> [a]
reverseList (x:xs) = (reverseList xs) ++ [x]
reverseList [] = []

createPalin :: [a] -> [a]
createPalin [] = []
createPalin xs = xs ++ (reverseList xs)

isPalin :: (Eq a) => [a] -> Bool
isPalin [] = True
isPalin xs = xs == (reverseList xs)

sortListOfList :: [[a]] -> [[a]]
sortListOfList [] = []
sortListOfList xs = sortBy compareByLength xs

compareByLength :: [a] -> [a] -> Ordering
compareByLength xs ys
  | lengthxs > lengthys = GT
  | lengthxs < lengthys = LT
  | otherwise = EQ
  where
    lengthxs = length xs
    lengthys = length ys

intersperse' :: a -> [[a]] -> [a]
intersperse' _ [] = []
intersperse' _ (x:[]) = x
intersperse' sep (x:xs) = x ++ [sep] ++ intersperse' sep xs
