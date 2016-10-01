{-# OPTIONS_GHC -Wall #-}

import           Data.List (sort)

data DayOfWeek = Mon | Tue | Wed | Thu | Fri | Sat | Sun
instance Eq DayOfWeek where
  (==) Mon Mon = True
  (==) Tue Tue = True
  (==) Wed Wed = True
  (==) Thu Thu = True
  (==) Fri Fri = True
  (==) Sat Sat = True
  (==) Sun Sun = True
  (==) _ _     = False

data Date = Date' DayOfWeek Int
instance Eq Date where
  (==) (Date' dayOfWeek dayOfMonth) (Date' dayOfWeek' dayOfMonth') =
    dayOfWeek == dayOfWeek' && dayOfMonth == dayOfMonth'

data Identity a = Identity' a
instance Eq a => Eq (Identity a) where
  (==) (Identity' v) (Identity' v') =
    v == v'

data Person = Person Bool deriving Show
printPerson :: Person -> IO()
printPerson person = putStrLn (show person)

data Mood = Blah | Woot deriving (Show,Eq)
settleDown :: Mood -> Mood
settleDown x = if x == Woot then Blah else x

type Subject = String
type Verb = String
type Object = String

data Sentence = Sentence Subject Verb Object deriving (Eq,Show)
s1 :: Object -> Sentence
s1 = Sentence "dogs" "drool"
s2 :: Sentence
s2 = Sentence "Julie" "loves" "dogs"

data Rocks = Rocks String deriving (Eq, Show)
data Yeah = Yeah Bool deriving (Eq, Show)
data Papu = Papu Rocks Yeah deriving (Eq, Show)
instance Ord Papu where
  (<=) (Papu (Rocks _) (Yeah b)) (Papu (Rocks _) (Yeah b')) = b <= b'

phew :: Papu
phew = Papu (Rocks "chases") (Yeah True)

truth :: Papu
truth = Papu (Rocks "hello") (Yeah True)

equalityForAll :: Papu -> Papu -> Bool
equalityForAll p p' = p == p'

comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'

i :: Num a => a
i = 1

f :: RealFrac a => a
f = 1.0

freud :: Int -> Int
freud x = x

myX :: Num a => a
myX = 1
sigmund :: Num a => a -> a
sigmund _ = myX

jung :: [Int] -> Int
jung xs = head (sort xs)

young :: Ord a => [a] -> a
young xs = head (sort xs)

mySort :: [Char] -> [Char]
mySort = sort

signifier :: [Char] -> Char
signifier xs = head (mySort xs)
