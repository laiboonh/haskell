{-# OPTIONS_GHC -Wall #-}

import           Data.Char (digitToInt)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

safeLast :: [a] -> Maybe a
safeLast list =
  case list of
    []     -> Nothing
    (x:[]) -> Just x
    (_:xs) -> safeLast xs

safeTail :: [a] -> Maybe [a]
safeTail list =
  case list of
    []     -> Nothing
    (_:xs) -> Just xs

safeInit :: [a] -> Maybe [a]
safeInit [] = Nothing
safeInit xs = Just (safeInitAcc [] xs)

safeInitAcc :: [a] -> [a] -> [a]
safeInitAcc acc []     = acc
safeInitAcc acc (_:[]) = acc
safeInitAcc acc (x:xs) = safeInitAcc (acc ++ [x]) xs

splitWith :: (a->Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith p (x:xs) = if p x
  then
    [[x]] ++ (splitWith p xs)
  else
    splitWith p xs

transpose :: String -> String
transpose xs = unlines (map (\(x,y) -> [x,y]) (zip (ls!!0) (ls!!1)))
  where ls = lines xs

splitLines :: String -> [String]
splitLines [] = []
splitLines cs =
    let (prefix, suffix) = break isLineTerminator cs
    in  prefix : case suffix of
                ('\r':'\n':rest) -> splitLines rest
                ('\r':rest)      -> splitLines rest
                ('\n':rest)      -> splitLines rest
                _                -> []

isLineTerminator :: Char -> Bool
isLineTerminator c = c == '\r' || c == '\n'

asInt_fold :: [Char] -> Int
asInt_fold ('-':xs) = negate (asInt_fold xs)
asInt_fold xs       = foldl (\a b -> (a*10) + (digitToInt b)) 0 xs

concat' :: [[a]] -> [a]
concat' [] = []
concat' xs = foldr step [] xs
  where step x acc = x ++ acc

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' p xs = foldr step [] xs
  where step x acc = if (p x) then [x] ++ acc else []