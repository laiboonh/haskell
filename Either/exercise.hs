{-# OPTIONS_GHC -Wall #-}

notThe :: String -> Maybe String
notThe s
  | s == "the" = Nothing
  | otherwise = Just s

replaceThe :: String -> String
replaceThe s = unwords $ foldr f [] (words s)
  where f :: String -> [String] -> [String]
        f x acc = case (notThe x) of
          Nothing -> "a" : acc
          Just y -> y : acc

vowelInitialWord :: String -> Bool
vowelInitialWord "" = False
vowelInitialWord (x:_) = elem x "aeiou"

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel s = go (words s) 0
  where go :: [String] -> Integer -> Integer
        go (x1:x2:xs) acc
          | x1 == "the" && vowelInitialWord x2  = go xs (acc+1)
          | otherwise = go xs acc
        go _ acc = acc

vowel :: Char -> Bool
vowel c = elem c "aeiou"

countVowels :: String -> Integer
countVowels s = foldr (\x acc ->if vowel x then acc+1 else acc) 0 s
