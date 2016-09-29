# Types

#### type synonym. String is synonym for [Char]
```haskell
λ> :i String
type String = [Char]    -- Defined in ‘GHC.Base’
```

#### type constructor can be values of a particular type
````haskell
data Bool = False | True
````

#### type constructor can be functions to create values of a particular type
```haskell
data Maybe a = Nothing | Just a
```

#### **type variable** *a* is *constrained* to the Num **type class**
```haskell
λ> :t 1
1 :: Num a => a
```

#### variable x is a **concrete type**
```haskell
λ> let x = 1 :: Int
λ> :t x
x :: Int
```

# 3 kinds of type signatures

#### Parametric polymorphism (maximum polymorphism a can be anything)
```haskell
id :: a -> a
```
#### Constrained polymorphism (potential type of a is reduced however there are common functions of Num that can be used now)
```haskell
negate :: Num a => a -> a
```
#### Concrete type (can make use of common methods of Num as well as Fractional)
```haskell
λ> let a = 1.0::Double
a :: Double
```
