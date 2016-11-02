# Applicative

| Monoid | Functor | Applicative (Monodial Functor) |
| --- | --- | --- |
| Mashing two values of the same type together via mappend | Function application over some structure leaving the structure undisturbed | Function and value both have structure, we have to mash the structure together and leave it intact |

#### Notice that f is constrained by the Functor typeclass
```haskell
class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
```

#### Tuple implementation for Applicative do not require b to be Monoid
```haskell
λ> :i (,)
data (,) a b = (,) a b 	-- Defined in ‘GHC.Tuple’
instance Monoid a => Applicative ((,) a) -- Defined in ‘GHC.Base’
```

#### Notice first value in tuple is mashed together using mappend, function application applies to second value only
```haskell
("Woo", (+1)) <*> (" Hoo!", 0)
("Woo Hoo!", 1)
```

#### Cartesian products
```haskell
λ> (,) <$> [1, 2] <*> [3, 4]
[(1,3),(1,4),(2,3),(2,4)]
λ> liftA2 (,) [1, 2] [3, 4]
[(1,3),(1,4),(2,3),(2,4)]
```
