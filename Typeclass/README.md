# Typeclasses
#### typeclasses allows us to generalize over a set of types in order to define and execute a standard set of features for those types

#### data declaration and the typeclasses it implements
```haskell
λ>:i Bool
data Bool = False | True        -- Defined in ‘GHC.Types’
instance Bounded Bool -- Defined in ‘GHC.Enum’
instance Enum Bool -- Defined in ‘GHC.Enum’
instance Eq Bool -- Defined in ‘GHC.Classes’
instance Ord Bool -- Defined in ‘GHC.Classes’
instance Read Bool -- Defined in ‘GHC.Read’
instance Show Bool -- Defined in ‘GHC.Show’
```
#### typeclass declaration, functions of this type class and instances of typeclass
```haskell
λ>:i Eq
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
instance (Eq a, Eq b) => Eq (Either a b) -- Defined in ‘Data.Either’
instance Eq a => Eq [a] -- Defined in ‘GHC.Classes’
```

#### A Baz have to be a Foo. Methods in Baz do not override methods in Foo. Typeclass inheritance is additive in nature. The following code cannot compile
```haskell
class Foo a where
  bar :: a -> String

class (Foo a) => Baz a where
  bar :: a -> String
```