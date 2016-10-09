{-# OPTIONS_GHC -Wall #-}

module Cipher where

import Data.Char

ordFirst :: Int
ordFirst = ord ' '

ordLast :: Int
ordLast = ord '~'

shiftAmount :: Int
shiftAmount = 5

caesar :: String -> String
caesar xs = map (shiftRight shiftAmount) xs

shiftRight :: Int -> Char -> Char
shiftRight i x =
  case expr > ordLast of
    True -> chr $ (ordFirst-1) + (expr - ordLast)
    False -> chr $ expr
    where expr = (ord x) + i
