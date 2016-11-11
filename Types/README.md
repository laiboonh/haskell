# Types
### "A type can be thought of as an enumeration of constructors that have zero or more arguments"

#### type synonym. String is synonym for [Char]
```haskell
λ> :i String
type String = [Char]    -- Defined in ‘GHC.Base’
```

#### type constructor with no arguments (type constant) and data constructors with no arguments (constant)
#### such constructors are also known as *nullary constructors*
#### Bool is a *sum type* as it has more than one data constructor
#### type constructors are used at *type level* (type signatures, type class declarations and instances) only
#### data constructors are used at the *term level*, values you can interact with at runtime only
````haskell
data Bool = False | True
````

#### parametric type constructor must be *applied* to a *type constant* to become a concrete type
#### parametric data constructor must be *applied* to a *value* to become a concrete value
#### Maybe is a *sum type* as well
```haskell
data Maybe a = Nothing | Just a
```

#### To find out types of types (Kinds)
```haskell
λ> :k Maybe
Maybe :: * -> * -- like a function, waiting to be applied
λ> :k Bool
Bool :: * -- a fully applied concrete type
λ> :k True -- kinds is for type constructors only

<interactive>:1:1:
    Not in scope: type constructor or class ‘True’
```

#### Arity is the number of arguments that a function or constructor takes
#### Cardinality of a datatype is the number of possible values it defines
```haskell
data Quantum = Yes | No | Both --Quantum is a sum type, the cardinality of Quantum is 3
data Example = MakeExample Quantum Quantum deriving (Eq,Show) --Example is a product type, the cardinality of Example is the product of possible values of Quantum and Quantum which is 3*3 = 9
```
#### Cardinality of a function is the number of possible *implementations*
#### For a function a->b, the cardinality is b^a
```haskell
f :: Quantum -> Bool
f Yes = True
f No = True
f Both = True
--Another implementation
f :: Quantum -> Quantum
f Yes = False
f No = False
f Both = False
--basically all the possible combinations of 3 boolean values 2^3 = 8
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

### Conversion between types
```haskell
--fromIntegral converts Integer or Int to Num (polymorphic)
λ> :t fromIntegral
fromIntegral :: (Integral a, Num b) => a -> b
λ> :i Integral
...
instance Integral Integer -- Defined in ‘GHC.Real’
instance Integral Int -- Defined in ‘GHC.Real’
λ> let x = 10 :: Int
x :: Int
λ> let y = fromIntegral x
y :: Num b => b
```
```haskell
--round, ceiling or floor converts RealFrac(Float or Double) to Integral(Integer or Int)
λ> :t round
round :: (Integral b, RealFrac a) => a -> b
λ> :i RealFrac
...
instance RealFrac Float -- Defined in ‘GHC.Float’
instance RealFrac Double -- Defined in ‘GHC.Float’
λ> let x = 1.23 :: Float
x :: Float
λ> let y = round x
y :: Integral b => b
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

# Polymorphism

## Polymorphic data types
#### t is a **type variable**. Type variables must be lowercase whereas type must be uppercase.
#### List type is **parameterized** by a type just like function can be parameterized by some parameters.
```haskell
--Compare non-polymorphic vs polymorphic
data IntList = Empty | Cons Int IntList
  deriving Show

data List t = Empty' | Cons' t (List t)  
```

## Polymorphic functions
#### In polymorphic functions, the caller gets to pick the types.
```haskell
--Compare non-polymorphic vs polymorphic
keepOnlyEven :: IntList -> IntList
keepOnlyEven Empty = Empty
keepOnlyEven (Cons x xs)
  | even x    = Cons x (keepOnlyEven xs)
  | otherwise = keepOnlyEven xs

filterList :: (t -> Bool) -> List t -> List t   
filterList _ Empty' = Empty'
filterList p (Cons' x xs)
  | p x       = Cons' x (filterList p xs)
  | otherwise = filterList p xs
```
