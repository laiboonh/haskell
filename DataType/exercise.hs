{-# OPTIONS_GHC -Wall #-}

module Cipher where

import           Data.Char

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

isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf lxs@(x:xs) (y:ys)
  | x == y = isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf lxs ys

capitalizeWords :: String -> [(String,String)]
capitalizeWords "" = []
capitalizeWords xs = map mkTuple (words xs)
  where mkTuple wd@(c:cs) = (wd, (toUpper c):cs)
        mkTuple [] = error "mkTuple empty string"

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = (toUpper x):xs

capitalizeParagraph :: String -> String
capitalizeParagraph [] = []
capitalizeParagraph xs = unsentence $ map capitalizeSentence (sentence xs)

sentence :: String -> [String]
sentence xs = reverse $ go [] xs
  where go :: [String] -> String -> [String]
        go acc [] = acc
        go acc xs' = go (first : acc) rest
                     where first = takeWhile (/='.') xs
                           rest = drop 2 (dropWhile (/='.') xs')

unsentence :: [String] -> String
unsentence [] = []
unsentence xs = init $ foldr (\x acc -> x ++ ". " ++ acc) [] xs

capitalizeSentence :: String -> String
capitalizeSentence [] = []
capitalizeSentence xs = (capitalizeWord (head w)) ++ (' ' : (unwords $ tail w))
  where w = words xs
