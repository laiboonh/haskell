{-# OPTIONS_GHC -Wall #-}

data WhoCares a =
  ItDoesnt
  | Matter a
  | WhatThisIsCalled deriving (Eq, Show)

instance Functor WhoCares where
  fmap _ ItDoesnt = WhatThisIsCalled
  fmap _ WhatThisIsCalled = ItDoesnt
  fmap f (Matter a) = Matter (f a)

data CountingBad a =
  Heisenberg Int a
  deriving (Eq, Show)

instance Functor CountingBad where
  fmap f (Heisenberg i a) = Heisenberg (i+1) (f a)

lms :: [Maybe [Char]]
lms = [Just "Ave", Nothing, Just "woohoo"]

replaceWithP :: a -> Char
replaceWithP = const 'p'

data Two a b =
  Two a b
  deriving (Eq, Show)
data Or a b =
  First a
  | Second b
  deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance Functor (Or a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b)

data Possibly a =
  LolNope |
  Yeppers a
  deriving (Eq, Show)
instance Functor Possibly where
  fmap _ LolNope = LolNope
  fmap f (Yeppers a) = Yeppers (f a)

applyIfJust :: (a -> b) -> Possibly a -> Possibly b
applyIfJust f m = fmap f m

data Sum' a b =
  First' a |
  Second' b
  deriving (Eq, Show)
instance Functor (Sum' a) where
  fmap _ (First' a) = First' a
  fmap f (Second' b) = Second' (f b)
applyIfSecond :: (a -> b) -> (Sum' e) a -> (Sum' e) b
applyIfSecond f m = fmap f m

data Wrap f a =
  Wrap (f a)
  deriving (Eq, Show)

instance (Functor f) => Functor (Wrap f) where
  fmap f (Wrap fa) = Wrap (fmap f fa)

type Nat f g = forall a . f a -> g a
-- This'll work
maybeToList :: Nat Maybe []
maybeToList Nothing = []
maybeToList (Just a) = [a]
