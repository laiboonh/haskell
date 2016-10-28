module Main where

import           Test.Hspec
import           Test.QuickCheck

genTuple :: (Arbitrary a, Arbitrary b) => Gen (a,b)
genTuple = do
  a <- arbitrary
  b <- arbitrary
  return (a,b)

main :: IO ()
main = do
  sample (genTuple :: Gen(Int,Float))
