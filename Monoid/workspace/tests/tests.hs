{-# OPTIONS_GHC -Wall #-}

import           Data.Monoid
import           Test.QuickCheck

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


type Exclamation = String
type Adverb = String
type Noun = String
type Adjective = String

madLibbinBetter :: Exclamation
                   -> Adverb
                   -> Noun
                   -> Adjective
                   -> String
madLibbinBetter e adv noun adj = mconcat [e,"! he said ",adv," as he jumped into his car ",noun," and drove off with this ",adj, " wife."]


newtype First' a = First' {getFirst' :: Optional a} deriving (Eq,Show)

instance Monoid (First' a) where
  mempty = First' Nada
  mappend (First' Nada) (First' Nada) = First' Nada
  mappend (First' Nada) (First' (Only a)) = First' (Only a)
  mappend (First' (Only a)) _ = First' (Only a)

firstMappend :: First' a -> First' a -> First' a
firstMappend = mappend

type FirstMappend =
     First' String
  -> First' String
  -> First' String
  -> Bool

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    x <- arbitrary
    frequency [ (1, return (First' (Only x)))
              , (1, return (First' Nada))]

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

main :: IO ()
main = do
  quickCheck (monoidAssoc :: FirstMappend)
  quickCheck (monoidLeftIdentity :: First' String -> Bool)
  quickCheck (monoidRightIdentity :: First' String -> Bool)
