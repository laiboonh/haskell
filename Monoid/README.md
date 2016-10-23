# Monoid

### "A monoid is a binary associative operation with an identity"

#### "In Haskell, these algebras can be implemented with *typeclasses*; the *typeclasses* define the set of operations. When we talk about operations over a set, the set is the *type* the operations are for. The *instance* defines how each operation will perform for a given type or set."
```haskell
class Monoid a where
  mempty :: a --identity
  mappend :: a -> a -> a --how 2 values can be joined together
  mconcat :: [a] -> a
```

#### Some types have more than 1 monoid. For example Integer summation and multiplication are both monoidal. Hence there are two new types with two instance of Monoid
```haskell
λ> :m + Data.Monoid
λ> mappend (Sum 1) (Sum 2)
Sum {getSum = 3}
λ> mappend (Product 1) (Product 2)
Product {getProduct = 2}
```

#### Difference between associative and commutative
```haskell
--associative
λ> Sum 1 <> (Sum 2 <> Sum 3)
Sum {getSum = 6}
λ> (Sum 1 <> Sum 2) <> Sum 3
Sum {getSum = 6}
--commutative
λ> Sum 1 <> Sum 2
Sum {getSum = 3}
λ> Sum 2 <> Sum 1
Sum {getSum = 3}
--associative but not commutative
λ> "hello" <> (" " <> "world")
"hello world"
λ> ("hello" <> " ") <> "world"
"hello world"
λ> "hello " <> "world"
"hello world"
λ> "world" <> "hello "
"worldhello "
```

#### Monoid Laws
```haskell
--left identity
mappend mempty x = x
--right identity
mappend x mempty = x
--associativity
mappend x (mappend y z) = mappend (mappend x y) z
mconcat  = foldr mappend empty
```
