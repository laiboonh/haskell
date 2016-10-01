# Typeclasses
### "typeclasses allows us to generalize over a set of types in order to define and execute a standard set of features for those types"

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

#### Declaring a type and implementing a typeclass
#### info shows that in order to implement Show one has to minimally implement showsPrec or show method
```haskell
λ> :i Show
class Show a where
  showsPrec :: Int -> a -> ShowS
  show :: a -> String
  showList :: [a] -> ShowS
  {-# MINIMAL showsPrec | show #-}
        -- Defined in ‘GHC.Show’

--workspace.hs
data Mood = Blah | Woot
instance Show Mood where
  show Blah = "1"
  show Woot  = "2"

λ> :l workspace.hs
λ> Woot
2
it :: Mood
λ> Blah
1
it :: Mood  
```

#### Default implementation
```haskell
λ> data Mood = Mood' deriving Show
```

#### Implement typeclasses for value constructors without type variables
```haskell
data DayOfWeek = Mon | Tue | Wed | Thu | Fri | Sat | Sun
instance Eq DayOfWeek where
  (==) Mon Mon = True
  (==) Tue Tue = True
  (==) Wed Wed = True
  (==) Thu Thu = True
  (==) Fri Fri = True
  (==) Sat Sat = True
  (==) Sun Sun = True
  (==) _ _     = False
```
#### Implement typeclasses for value constructors with type variables
```haskell
data Date = Date' DayOfWeek Int
instance Eq Date where
  (==) (Date' dayOfWeek dayOfMonth) (Date' dayOfWeek' dayOfMonth') =
    dayOfWeek == dayOfWeek' && dayOfMonth == dayOfMonth'
```

#### What if the constructors type variables may or may not implement Eq
```haskell
data Identity a = Identity' a
instance Eq a => Eq (Identity a) where
  (==) (Identity' v) (Identity' v') =
    v == v'
```

#### Eq is a superclass of Ord, Ord is a subclass of Eq
```haskell
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<) :: a -> a -> Bool
  (<=) :: a -> a -> Bool
  (>) :: a -> a -> Bool
  (>=) :: a -> a -> Bool
  max :: a -> a -> a
  min :: a -> a -> a
  {-# MINIMAL compare | (<=) #-}
```
