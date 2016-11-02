{-# OPTIONS_GHC -Wall #-}

--import           Control.Applicative
import           Data.List (elemIndex)

--1.
added :: Maybe Integer
added = fmap (+3) (lookup 3 $ (zip [1, 2, 3] [4, 5, 6]::[(Integer,Integer)]))

--2.
y :: Maybe Integer
y = lookup 3 $ (zip [1, 2, 3] [4, 5, 6]::[(Integer,Integer)])

z :: Maybe Integer
z = lookup 2 $ (zip [1, 2, 3] [4, 5, 6]::[(Integer,Integer)])

tupled :: Maybe (Integer, Integer)
--tupled = liftA2 (,) y z
tupled = (,) <$> y <*> z

--3.
x :: Maybe Int
x = elemIndex 3 ([1, 2, 3, 4, 5]::[Int])

y' :: Maybe Int
y' = elemIndex 4 ([1, 2, 3, 4, 5]::[Int])

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = max' <$> x <*> y'

--4.
xs :: [Integer]
xs = [1, 2, 3]

ys :: [Integer]
ys = [4, 5, 6]

x' :: Maybe Integer
x' = lookup 3 $ zip xs ys

y'' :: Maybe Integer
y'' = lookup 2 $ zip xs ys

summed :: Maybe Integer
summed = fmap sum (Just 1, Just 2)
