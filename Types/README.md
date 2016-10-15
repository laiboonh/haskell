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
data Bool = True | False --Bool is a sum type, the cardinality of Bool is 2
data Example = MakeExample Int String deriving (Eq,Show) --Example is a product type, the cardinality of Example is the product of possible values of Int and String
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
