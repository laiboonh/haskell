module Main where

import           Test.QuickCheck

half :: Fractional a => a -> a
half x = x / 2

halfIdentity :: Fractional a => a -> a
halfIdentity = (*2) . half

propHalf :: Float -> Bool
propHalf f = halfIdentity f == f

main :: IO ()
main = quickCheck propHalf
