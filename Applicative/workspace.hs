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

const <$> Just "Hello" <*> pure "World"
