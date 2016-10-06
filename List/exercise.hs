{-# OPTIONS_GHC -Wall #-}

eftChar :: Char -> Char -> [Char]
eftChar x y = go x y []

eftBool :: Bool -> Bool -> [Bool]
eftBool x y = go x y []

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd x y = go x y []

eftInt :: Int -> Int -> [Int]
eftInt x y = go x y []

go :: (Ord a,Enum a) => a -> a -> [a] -> [a]
go x' y' acc
  | x' > y' = acc
  | x' == y' = acc ++ [x']
  | otherwise = go (succ x') y' (acc ++ [x'])

myWords :: String -> [String]
myWords x = go' x []
  where go' :: String -> [String] -> [String]
        go' [] acc = acc
        go' x' acc = go' ( dropWhileSpace (dropWhileNotSpace x')) (acc ++ [takeWhileNotSpace x'])

dropWhileSpace :: (String -> String)
dropWhileSpace = dropWhile (\x -> x == ' ')

dropWhileNotSpace :: (String -> String)
dropWhileNotSpace = dropWhile (\x -> x /= ' ')

takeWhileNotSpace :: (String -> String)
takeWhileNotSpace = takeWhile (\x -> x /= ' ')

mystery :: String -> [Bool]
mystery xs = map (\x-> elem x "aeiou") xs

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys
