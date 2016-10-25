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
