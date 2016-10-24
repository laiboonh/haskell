module Main where

import           Data.Char                 (toUpper)
import           Data.List                 (sort)
import           Test.QuickCheck
import           Test.QuickCheck.Function  (Fun (..))
import           Test.QuickCheck.Modifiers (NonZero)

half :: Fractional a => a -> a
half x = x / 2

halfIdentity :: Fractional a => a -> a
halfIdentity = (*2) . half

propHalf :: Float -> Bool
propHalf f = halfIdentity f == f

listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs = snd $ foldr go (Nothing, True) xs
  where go _ status@(_, False) = status
        go y (Nothing, t) = (Just y, t)
        go y (Just x, _) = (Just y, x >= y)
propSort :: [Integer] -> Bool
propSort = listOrdered . sort

functionCommutative :: (Integer -> Integer -> Integer) -> Integer -> Integer -> Bool
functionCommutative f x y = (f x y) == (f y x)

functionAssociative :: (Integer -> Integer -> Integer) -> Integer -> Integer -> Integer -> Bool
functionAssociative f x y z = ((x `f` y) `f` z) == (x `f` (y `f` z))

propQuotRem :: NonZero Integer -> NonZero Integer -> Bool
propQuotRem (NonZero x) (NonZero y) = (quot x y)*y + (rem x y) == x

propDivMod :: NonZero Integer -> NonZero Integer -> Bool
propDivMod (NonZero x) (NonZero y) = (div x y)*y + (mod x y) == x

propReverse :: [Integer] -> Bool
propReverse xs = (reverse . reverse) xs == xs

propApply :: Fun Integer Integer -> Integer -> Bool
propApply (Fun _ f) x = (f $ x) == (f x)

propCompose :: Fun Integer Integer -> Fun Integer Integer -> Integer -> Bool
propCompose (Fun _ f) (Fun _ g) x = (f . g) x == f (g x)

propFoldr :: [Integer] -> [Integer] -> Bool
propFoldr xs ys = foldr (:) xs ys == (++) xs ys

propConcat :: [[Integer]] -> Bool
propConcat xs = (foldr (++) [] xs) == (concat xs)

propTake :: Int -> [Integer] -> Bool
propTake n xs = length (take n xs) == n

propReadShow :: Integer -> Bool
propReadShow x = (read (show x)) == x

square :: Num a => a -> a
square x = x * x

propSquareIdentity :: Float -> Bool
propSquareIdentity x = (square (sqrt x)) == x

twice :: ([a] -> [a]) -> ([a] -> [a])
twice f = f . f

fourTimes :: ([a] -> [a]) -> ([a] -> [a])
fourTimes = twice . twice

capitalizeWord :: String -> String
capitalizeWord xs = map toUpper xs

propCapitalizeWord :: String -> Bool
propCapitalizeWord xs = (capitalizeWord xs == (twice capitalizeWord) xs) == (capitalizeWord xs == (fourTimes capitalizeWord) xs)

propSort' :: String -> Bool
propSort' xs = (sort xs == (twice sort) xs) == (sort xs == (fourTimes sort) xs)

data Fool =
  Fulse |
  Frue
  deriving (Eq,Show)

fulseFrue :: Gen Fool
fulseFrue = elements [Fulse,Frue]

fulseFrue' :: Gen Fool
fulseFrue' = elements [Fulse,Fulse,Frue]

main :: IO ()
main = do
  quickCheck propHalf
  quickCheck propSort
  quickCheck $ functionCommutative (+)
  quickCheck $ functionAssociative (+)
  quickCheck $ functionCommutative (*)
  quickCheck $ functionAssociative (*)
  quickCheck propReverse
  quickCheck propQuotRem
  quickCheck $ propApply
  quickCheck $ propCompose
  quickCheck $ propConcat
--  quickCheck $ propTake
--  quickCheck $ propReadShow
--  quickCheck $ propSquareIdentity
  quickCheck $ propCapitalizeWord
  quickCheck $ propSort'
