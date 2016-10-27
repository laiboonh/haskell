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

#### Implementing an instance of Semigroup
```haskell
data Validation a b =
  Failure a |
  Success b
  deriving (Eq,Show)
instance Semigroup a => Semigroup (Validation a b) where
  (Failure a) <> (Failure b)  = Failure (a <> b)
  (Failure a) <> _            = Failure a
  _           <> (Failure a)  = Failure a
  a           <> _            = a
```

#### Doing QuickCheck on Semigroup
```haskell  
instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(Failure a), (Success b)]

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)
type ValidationAssoc = Validation String String -> Validation String String  -> Validation String String -> Bool

main :: IO ()
main = do
  quickCheck (semigroupAssoc :: ValidationAssoc)
```
