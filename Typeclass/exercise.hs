{-# OPTIONS_GHC -Wall #-}

data TisAnInteger = TisAn Integer
instance Eq TisAnInteger where
  (==) (TisAn i) (TisAn i') = i == i'

data TwoIntegers = Two Integer Integer
instance Eq TwoIntegers where
  (==) (Two i1 i2) (Two i1' i2') =
    i1 == i1' && i2 == i2'

data StringOrInt = TisAnInt Int | TisAString String
instance Eq StringOrInt where
  (==) (TisAnInt i) (TisAnInt i')     = i == i'
  (==) (TisAString s) (TisAString s') = s == s'
  (==) _ _                            = False

data Pair a = Pair a a
instance Eq a => Eq (Pair a) where
  (==) (Pair v1 v2) (Pair v1' v2') =
    v1 == v1' && v2 == v2'

data Tuple a b = Tuple a b
instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple x y) (Tuple x' y') =
    x == x' && y == y'

data Which a = ThisOne a | ThatOne a
instance Eq a => Eq (Which a) where
  (==) (ThisOne x) (ThisOne x') = x == x'
  (==) (ThatOne x) (ThatOne x') = x == x'
  (==) _ _                      = False

data EitherOr a b = Hello a | Goodbye b
instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello x) (Hello x')     = x == x'
  (==) (Goodbye y) (Goodbye y') = y == y'
  (==) _ _                      = False
