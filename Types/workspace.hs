{-# OPTIONS_GHC -Wall #-}

class Listable a where
  toList :: a -> [Integer]
instance Listable Integer where
  toList x = [x]
instance (Listable a, Listable b) => Listable (a,b) where
  toList (x,y) = toList x ++ toList y
instance Listable Bool where
  toList True = [1]
  toList False = [0]
