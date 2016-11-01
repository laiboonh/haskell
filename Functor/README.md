# Functor

### "A functor is a way to apply a function over or around some structure that we don’t want to alter."

#### Take note that f is a *non concrete* type constructor
```haskell
λ> :i Functor
class Functor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a

data FixMePls a =
  FixMe |
  Pls a
  deriving (Eq, Show)
--This will not compile
instance Functor (FixMePls a) where
  fmap _ _ = undefined
--This will compile
instance Functor FixMePls where
  fmap _ _ = undefined
```

### Functor Laws

#### Identity
```haskell
λ> fmap id "hello world" == id "hello world"
True
```
#### Composition
```haskell
λ> let xs = [1,2,3]
λ> fmap ((+1).(*2)) xs == fmap (+1) . fmap (*2) $ xs
True
```

#### Structural Preservation
#### "f persists through the type of fmap, whatever the type is, we know it must be a type that can take an argument, as in f a and f b and that it will be the “structure” we’re lifting the function over when we apply it to the value inside."
```haskell
fmap :: Functor f => (a -> b) -> f a -> f b
```

#### Implement Functor instance
```haskell
data WhoCares a =
  ItDoesnt
  | Matter a
  | WhatThisIsCalled deriving (Eq, Show)

instance Functor WhoCares where
  fmap _ ItDoesnt = ItDoesnt
  fmap _ WhatThisIsCalled = WhatThisIsCalled
  fmap f (Matter a) = Matter (f a)
```
#### Breaking the functor law
#### "Think of anything that isn’t the final type argument of our f in Functor as being part of the structure that the functions being li ed should be oblivious to."
```haskell
data CountingBad a =
  Heisenberg Int a
  deriving (Eq, Show)

instance Functor CountingBad where
  fmap f (Heisenberg i a) = Heisenberg (i+1) (f a)

λ> fmap ((++"!").(++"world")) (Heisenberg 1 "hello") == (fmap (++"!") . fmap (++"world") $ (Heisenberg 1 "hello"))
False  
```

#### Stacked functors
```haskell
lms :: [Maybe [Char]]
lms = [Just "Ave", Nothing, Just "woohoo"]

replaceWithP :: a -> Char
replaceWithP = const 'p'

λ> :t (fmap . fmap)
(fmap . fmap)
  :: (Functor f, Functor f1) => (a -> b) -> f (f1 a) -> f (f1 b)
--preserve the "structure of the structure"
λ> (fmap.fmap) replaceWithP lms
[Just 'p',Nothing,Just 'p']
--preserve the "structure of the structure of the structure"
λ> (fmap.fmap.fmap) replaceWithP lms
[Just "ppp",Nothing,Just "pppppp"]
```

#### `fmap (+1) (1,2) = (1,3)` why?
```haskell
data Two a b =
  Two a b
  deriving (Eq, Show)
data Or a b =
  First a
  | Second b
  deriving (Eq, Show)
λ> :k Two
Two :: * -> * -> *
λ> :k Or
Or :: * -> * -> *  
--these are not compatible with Functor instance which expects * -> *
--hence we partially apply function
instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)
instance Functor (Or a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b)
```
#### Useful in cases like Either where we do not have to apply function to left value
```haskell
λ> fmap (+1) (Left "fail")
Left "fail"
λ> fmap (+1) (Right 1)
Right 2
```

#### Natural Transformation - transform only the structure and leave the type argument to that structure or type constructor alone
```haskell
type Nat f g = forall a . f a -> g a
-- This'll work
maybeToList :: Nat Maybe []
maybeToList Nothing = []
maybeToList (Just a) = [a]

λ> maybeToList (Just 100)
[100]
```
