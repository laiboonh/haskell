class Foo a where
  bar :: a -> String

class (Foo a) => Baz a where
  bar :: a -> String


data Mood = Blah | Yay
instance Show Mood where
  show :: a -> String
  show Blah = "1"
  show Yay  = "2"
