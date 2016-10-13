{-# OPTIONS_GHC -Wall #-}

import           Data.Char (toUpper)

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

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = (f x y) : zipWith' f xs ys

zip'' :: [a] -> [b] -> [(a,b)]
zip'' xs ys = zipWith' (,) xs ys

capitalise :: String -> String
capitalise "" = ""
capitalise (c:cs) = toUpper c : cs

echo :: String -> String
echo "" = ""
echo (c:cs) = toUpper c : echo cs

firstLetter :: String -> Maybe Char
firstLetter "" = Nothing
firstLetter (c:_) = Just $ toUpper c

myOr :: [Bool] -> Bool
myOr [] = False
myOr (b:bs)
  | b == True = True
  | otherwise = myOr bs

myAny :: (a->Bool) -> [a] -> Bool
myAny _ [] = False
myAny p (x:xs)
  | p x == True = True
  | otherwise = myAny p xs

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem n (x:xs)
  | n == x = True
  | otherwise = myElem n xs

myElem' :: Eq a => a -> [a] -> Bool
myElem' n xs = myAny (n==) xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = (f x) ++ (squishMap f xs)

squishAgain :: [[a]] -> [a]
squishAgain xs = squishMap id xs

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = undefined
myMaximumBy _ (x:[]) = x
myMaximumBy f (x:xs) =
  case f x maxRestOfList of
    GT -> x
    _ -> maxRestOfList
    where maxRestOfList = myMaximumBy f xs


myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = undefined
myMinimumBy _ (x:[]) = x
myMinimumBy f (x:xs) =
  case f x maxRestOfList of
    LT -> x
    _ -> maxRestOfList
    where maxRestOfList = myMinimumBy f xs

maximum' :: (Ord a) => [a] -> a
maximum' xs = myMaximumBy compare xs

minimum' :: (Ord a) => [a] -> a
minimum' xs = myMinimumBy compare xs

stops :: [Char]
stops = "pbtdkg"

vowels :: [Char]
vowels = "aeiou"

threeLetterWord :: [(Char,Char,Char)]
threeLetterWord = [(x,y,z) | x<-stops, y<-vowels, z<-stops, x/=z, x=='p']

myOr' :: [Bool] -> Bool
myOr' = foldr (||) False

myAny' :: (a->Bool) -> [a] -> Bool
myAny' p = foldr ((||) . p) False

myElem'' :: Eq a => a -> [a] -> Bool
myElem'' x = foldr ((||) . (==x)) False

myElem''' :: Eq a => a -> [a] -> Bool
myElem''' x = any (==x)

myReverse' :: [a] -> [a]
myReverse' = foldl (flip (:)) []

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr ((:) . f) []

myFilter :: (a->Bool) -> [a] -> [a]
myFilter p = foldr (\x acc -> if (p x) then x:acc else acc) []

squish' :: [[a]] -> [a]
squish' = foldr (++) []

squishMap' :: (a->[b]) -> [a] -> [b]
squishMap' f = foldr ((++).f) []

squishAgain' :: [[a]] -> [a]
squishAgain' = squishMap' id
