module WordNumber where

import           Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n
  | n == 1 = "one"
  | n == 2 = "two"
  | n == 3 = "three"
  | n == 4 = "four"
  | n == 5 = "five"
  | n == 6 = "six"
  | n == 7 = "seven"
  | n == 8 = "eigth"
  | n == 9 = "nine"

digits :: Int -> [Int]
digits n = go n []
  where go :: Int -> [Int] -> [Int]
        go 0 acc = acc
        go n' acc = go (fst divModTup) (snd divModTup : acc) where divModTup = n' `divMod` 10


digitsToWords :: Int -> [String]
digitsToWords n = map digitToWord (digits n)

intersperseWithDash :: [String] -> [String]
intersperseWithDash = intersperse "-"

wordNumber :: Int -> String
wordNumber = unwords . intersperseWithDash . digitsToWords
