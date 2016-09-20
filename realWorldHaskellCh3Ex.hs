{-# OPTIONS_GHC -Wall #-}

count :: [a] -> Integer
count (_:xs) = 1 + count xs
count []     = 0

count' :: Integer -> [a] -> Integer
count' acc (_:xs) = count' (acc + 1) xs
count' acc []     = acc
