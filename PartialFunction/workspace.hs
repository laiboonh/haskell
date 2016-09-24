{-# OPTIONS_GHC -Wall #-}

head' :: [a] -> a
head' [] = error "empty list"
head' (x:_) = x

length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs

all' :: (a->Bool) -> [a] -> Bool
all' _ [] = True
all' predicate (x:xs) = (predicate x) && (all' predicate xs)
