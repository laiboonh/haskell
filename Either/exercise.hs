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

isVowel :: Char -> Bool
isVowel c = elem c vowels

countVowels :: String -> Int
countVowels s = foldr (\x acc ->if isVowel x then acc+1 else acc) 0 s

newtype Word' = Word' String deriving (Eq,Show)

vowels :: String
vowels = "aeiou"

mkWord :: String -> Maybe Word'
mkWord s = case moreThanHalf (numberOfVowels s) (length s) of
  True -> Nothing
  _ -> Just (Word' s)
  where numberOfVowels = countVowels

moreThanHalf :: (Ord a, Integral a) => a -> a -> Bool
moreThanHalf x1 x2
  | x1 > (x2 `div` 2) = True
  | otherwise = False

data Nat =
  Zero
  | Succ Nat
  deriving (Eq,Show)

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ Zero) = 1
natToInteger (Succ nat) = 1 + natToInteger nat

integerToNat :: Integer -> Maybe Nat
integerToNat i
  | i < 0 = Nothing
  | otherwise = Just (go i)
    where go :: Integer -> Nat
          go 0 = Zero
          go 1 = Succ Zero
          go x = Succ (go (x-1))

isJust :: Maybe a -> Bool
isJust Nothing = False
isJust (Just _) = True

isNothing :: Maybe a -> Bool
isNothing m = not $ isJust m

mayybee :: b -> (a->b) -> Maybe a -> b
mayybee x _ (Nothing) = x
mayybee _ f (Just a) = f a

fromMaybe :: a -> Maybe a -> a
fromMaybe x Nothing = x
fromMaybe _ (Just a) = a

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just a) = [a]

catMaybes :: [Maybe a] -> [a]
catMaybes xs = foldr f [] xs
  where f :: Maybe a -> [a] -> [a]
        f Nothing acc = acc
        f (Just a) acc = a:acc

flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe [] = Nothing
flipMaybe lst = case go lst of
  [] -> Nothing
  ys -> Just ys
  where go :: [Maybe a] -> [a]
        go [] = []
        go (Nothing:_) = []
        go ((Just a):xs) = a : (go xs)

lefts' :: [Either a b] -> [a]
lefts' lst = foldr f [] lst
  where f :: (Either a b) -> [a] -> [a]
        f (Left a) acc = a:acc
        f _ acc = acc

rights' :: [Either a b] -> [b]
rights' lst = foldr f [] lst
  where f :: (Either a b) -> [b] -> [b]
        f (Right b) acc = b:acc
        f _ acc = acc

partitionEithers' :: [Either a b] -> ([a],[b])
partitionEithers' lst = (lefts' lst,rights' lst)

eitherMaybe' :: (b->c) -> Either a b -> Maybe c
eitherMaybe' _ (Left _) = Nothing
eitherMaybe' f (Right b) = Just (f b)

either' :: (a->c) -> (b->c) -> Either a b -> c
either' f1 _ (Left a) = f1 a
either' _ f2 (Right b) = f2 b

eitherMaybe'' :: (b->c) -> Either a b -> Maybe c
eitherMaybe'' f e = either' (\_->Nothing) (\x->Just(f x)) e

myIterate :: (a->a) -> a -> [a]
myIterate f x = x:(myIterate f y)
  where y = f x

myUnfoldr :: (b->Maybe(a,b)) -> b -> [a]
myUnfoldr f x = case (f x) of
  Nothing -> []
  Just (a,b) -> a : myUnfoldr f b

betterIterate :: (a->a) -> a -> [a]
betterIterate f a = myUnfoldr (\x -> Just (x,(f x))) a

data BinaryTree a =
  Leaf |
  Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq,Ord,Show)

unfold :: (a->Maybe(a,b,a)) -> a -> BinaryTree b
unfold f x = case (f x) of
  Nothing -> Leaf
  Just (a1,b,a2) -> Node (unfold f a1) b (unfold f a2)

treeBuild :: Integer -> BinaryTree Integer
treeBuild n = unfold f 0
  where f m
          | m == n = Nothing
          | otherwise = Just (m + 1, m, m + 1)
