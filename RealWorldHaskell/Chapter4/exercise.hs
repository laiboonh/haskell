{-# OPTIONS_GHC -Wall #-}

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
