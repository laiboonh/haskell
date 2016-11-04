{-# OPTIONS_GHC -Wall #-}

--import           Control.Applicative
newtype Name =
  Name String
  deriving (Eq, Show)
newtype Address =
  Address String
  deriving (Eq, Show)
data Person =
  Person Name Address
  deriving (Eq, Show)

data List a =
  Nil |
  Cons a (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a la) = Cons (f a) (fmap f la)

instance Applicative List where
  pure x = Cons x Nil
  (<*>) fs xs = fold fun Nil fs where
    fun f acc = append (fmap f xs) acc

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x $ xs `append` ys

fold :: (a -> b -> b) -> b -> List a -> b
fold _ b Nil = b
fold f b (Cons h t) = f h (fold f b t)

concat' :: List (List a) -> List a
concat' = fold append Nil

flatMap :: (a -> List b) -> List a -> List b
flatMap f as = concat' $ fmap f as

values :: List Integer
values = Cons 1 (Cons 2 Nil)

functions :: List (Integer->Integer)
functions = Cons (+1) (Cons (*2) Nil)
