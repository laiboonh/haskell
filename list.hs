{-# OPTIONS_GHC -Wall #-}

data List a = Cons a (List a) | Nil deriving Show

list1 :: List Int
list1 = Nil

list2 :: List Int
list2 = Cons 1 list1

fromList :: [a] -> List a
fromList (x:xs) = Cons x (fromList xs)
fromList [] = Nil

fromList' :: List a -> [a]
fromList' (Cons x xs) = x:(fromList' xs)
fromList' Nil = []
