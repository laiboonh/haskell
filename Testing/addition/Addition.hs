module Addition where

import           Test.Hspec
import           Test.QuickCheck

dividedBy :: Integral a => a -> a -> (a,a)
dividedBy num denom = go num denom 0
  where
    go n d count
      | n < d = (count,n)
      | otherwise = go (n-d) d (count+1)

multiplyBy :: (Ord a, Num a) => a -> a -> a
multiplyBy num multiplier = go num multiplier 0
  where
    go n m acc
      | m == 0 = acc
      | m < 0 = go n (m+1) (acc-n)
      | otherwise = go n (m-1) (acc+n)

main :: IO ()
main = hspec $ do
  describe "Addition" $ do
    it "1 + 1 is greater than 1" $ do
      (1+1) > (1::Integer) `shouldBe` True
    it "2 + 2 is equal to 4" $ do
      2+(2::Integer) `shouldBe` 4
    it "15 divied by 3 is 5" $ do
      (15::Integer) `dividedBy` 3 `shouldBe` (5,0)
    it "22 dividedBy 5 is 4 remainder 2" $ do
      (22::Integer) `dividedBy` 5 `shouldBe` (4,2)
    it "2 multiplyBy 3 is 6" $ do
      (2::Integer) `multiplyBy` 3 `shouldBe` 6
    it "2 multiplyBy 0 is 0" $ do
      (2::Integer) `multiplyBy` 0 `shouldBe` 0
    it "-2 multiplyBy 3 is -6" $ do
      (-2::Integer) `multiplyBy` 3 `shouldBe` (-6)
    it "2 multiplyBy -3 is -6" $ do
      (2::Integer) `multiplyBy` (-3) `shouldBe` (-6)
    it "x + 1 is always greater than x" $ do
      property $ \x -> x + 1 > (x::Int)
