# Functor

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
