{-# OPTIONS_GHC -Wall #-}

data Optional a =
  Nada |
  Only a
  deriving (Eq,Show)

instance Monoid a => Monoid (Optional a) where
  mempty = Nada
  mappend Nada (Only a) = Only a
  mappend (Only _) Nada = Nada
  mappend Nada Nada = Nada
  mappend (Only a1) (Only a2) = Only (mappend a1 a2)
