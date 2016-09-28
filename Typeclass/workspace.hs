class Foo a where
  bar :: a -> String

class (Foo a) => Baz a where
  bar :: a -> String
