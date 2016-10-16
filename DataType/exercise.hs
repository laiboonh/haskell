{-# OPTIONS_GHC -Wall #-}

module Cipher where

import Data.Char

ordFirst :: Int
ordFirst = ord 'A'

ordLast :: Int
ordLast = ord 'Z'

shiftRight :: Int -> Char -> Char
shiftRight i x =
  case expr > ordLast of
    True -> chr $ (ordFirst-1) + (expr - ordLast)
    False -> chr $ expr
    where expr = (ord x) + i

shiftAmt :: Char -> Int
shiftAmt = (`mod` 65).ord

caesar :: String -> String -> String -> String
caesar [] _ acc = reverse acc
caesar _ [] _ = []
caesar (x:xs) (y:ys) acc
  | x == ' ' = caesar xs (y:ys) ((shiftRight 0 x) : acc)
  | otherwise = caesar xs ys ((shiftRight (shiftAmt y) x) : acc)
