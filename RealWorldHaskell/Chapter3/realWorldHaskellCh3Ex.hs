{-# OPTIONS_GHC -Wall #-}

count :: [a] -> Integer
count (_:xs) = 1 + count xs
count []     = 0

count' :: Integer -> [a] -> Integer
count' acc (_:xs) = count' (acc + 1) xs
count' acc []     = acc

sumList :: (Num a) => [a] -> a
sumList [] = 0
sumList (x:xs) = x + (sumList xs)

lengthList :: (Num a) => [t] -> a
lengthList [] = 0
lengthList (_:xs) = 1 + (lengthList xs)

meanList :: (Integral a, Fractional b) => [a] -> b
meanList xs = fromIntegral(sumList xs) / (lengthList xs)

reverseList :: [a] -> [a]
reverseList (x:xs) = (reverseList xs) ++ [x]
reverseList [] = []

createPalin :: [a] -> [a]
createPalin [] = []
createPalin xs = xs ++ (reverseList xs)

isPalin :: (Eq a) => [a] -> Bool
isPalin [] = True
isPalin xs = xs == (reverseList xs)
