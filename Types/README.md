# Types

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
