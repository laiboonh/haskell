# Semigroup

#### Semigroup provides a binary associative operation, but doesn't have an identity value. In that sense it's a weaker algebra.
```haskell
class Semigroup a where
  (Data.Semigroup.<>) :: a -> a -> a
```

#### NonEmpty list type has a Semigroup instance
```haskell
λ> import qualified Data.List.NonEmpty
λ> :i Data.List.NonEmpty.NonEmpty
data NonEmpty a = a :| [a] 	-- Defined in ‘Data.List.NonEmpty’
λ> let xs = 1 :| [2,3] :: (NonEmpty Int)
λ> let ys = 4 :| [5,6] :: (NonEmpty Int)
λ> xs <> ys
1 :| [2,3,4,5,6]
```
