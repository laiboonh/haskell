{-# OPTIONS_GHC -Wall #-}

import           Data.List (sortBy)

count :: [a] -> Integer
count (_:xs) = 1 + count xs
count []     = 0

count' :: Integer -> [a] -> Integer
count' acc (_:xs) = count' (acc + 1) xs
count' acc []     = acc

sumList :: (Num t) => [t] -> t
sumList []     = 0
sumList (x:xs) = x + (sumList xs)

lengthList :: [a] -> Int
lengthList []     = 0
lengthList (_:xs) = 1 + (lengthList xs)

meanList :: (Fractional a) => [a] -> a
meanList xs = (sumList xs) / fromIntegral(lengthList xs)

reverseList :: [a] -> [a]
reverseList (x:xs) = (reverseList xs) ++ [x]
reverseList []     = []

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
    lengthxs = lengthList xs
    lengthys = lengthList ys

intersperse :: a -> [[a]] -> [a]
intersperse _ []       = []
intersperse _ (x:[])   = x
intersperse sep (x:xs) = x ++ [sep] ++ intersperse sep xs

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

treeHeight :: Tree a -> Int
treeHeight Empty            = 0
treeHeight (Node _ (l) (r)) = 1 + (max (treeHeight l) (treeHeight r))

simpleTree :: Tree [Char]
simpleTree = Node "parent" (Node "left child" Empty Empty)
                           (Node "right child" Empty Empty)
