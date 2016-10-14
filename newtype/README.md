# newtype

### "A *newtype* cannot be a product type, sum type or contain nullary constructors"

### Why do we need newtype

#### 1. Type safety
```haskell
tooManyGoats :: Int -> Bool
tooManyGoats n = n > 42

newtype Goats = Goats Int deriving (Eq,Show)
newtype Cows = Cows Int deriving (Eq,Show)

tooManyGoats :: Goats -> Bool
tooManyGoats (Goats n) = n > 42

tooManyGoats (Cows 43) -- won't compile
```

#### 2. Typeclass. To define different instances for the same type
```haskell
class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

tooMany (43 :: Int) --True

instance TooMany Goats where
  tooMany (Goats n) = n > 43

tooMany (Goats 44) --True  
```
#### To reuse the typeclass instance of the type our newtype contains
```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

newtype Goats = Goats Int deriving (Eq,Show,TooMany)
```

```haskell
{-# LANGUAGE FlexibleInstances #-}

instance TooMany (Int,String) where
  tooMany (n,s) = length s == n

tooMany (1::Int,"h") -- True  
```
