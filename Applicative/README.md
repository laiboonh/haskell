# Applicative

### "Applicative is function application that preserves structure. However, with applicative, since the function being applied also has structure, the structures have to be monoidal and come together in some fashion."

| Monoid | Functor | Applicative (Monodial Functor) |
| --- | --- | --- |
| Mashing two values of the same type together via mappend | Function application over some structure leaving the structure undisturbed | Function and value both have structure, we have to mash the structure together and leave it intact |
| mappend (<>) | fmap (<$>) | ap (<*>) |

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

#### Example usage
```haskell
λ> (,,,) <$> (Just 90) <*> (Just 10) <*> (Just "Tiredness") <*> pure [1,2,3,4]
--fmap : lift over Maybe first Just (,,,90)
--applicative : Just (90,,,) <*> Just 10 = Just (90,10,,) and so on
Just (90,10,"Tiredness",[1,2,3,4])
```

### Applicative Laws

#### Identity
```haskell
pure id <*> v = v
λ> pure id <*> (Just 10)
Just 10
--compare with Functor
λ> id <$> [1..5]
[1,2,3,4,5]
λ> pure id <*> [1..5]
[1,2,3,4,5]
```
#### Composition
```haskell
pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
λ> pure (.) <*> [(+1)] <*> [(*2)] <*> [1, 2, 3]
-- pure (.) <*> [(+1)] = [(+1).]
-- [(+1).] <*> [(*2)] = [(+1).(*2)]
[3,5,7]
λ> [(+1)] <*> ([(*2)] <*> [1, 2, 3])
[3,5,7]
```
#### Homomorphism "The effect of applying a function that is embedded in some structure to a value that is embedded in some structure should be the same as applying a function to a value without affecting any outside structure"
```haskell
pure f <*> pure x = pure (f x)
λ> pure (+1) <*> pure 1
2
λ> pure ((+1) 1)
2
```
#### Interchange
```haskell
u <*> pure y = pure ($ y) <*> u
λ> (Just (+2) <*> pure 2) == (pure ($ 2) <*> Just (+2))
-- pure ($ 2) <*> Just (+2) = Just (($ 2) (+2))
True
```

#### Testing the Applicative Laws using checkers
```haskell
λ> :t applicative
applicative
  :: (EqProp (m c), EqProp (m b), EqProp (m a),
      Arbitrary (m (b -> c)), Arbitrary (m (a -> b)), Arbitrary (m a),
      Arbitrary b, Arbitrary a, CoArbitrary a, Applicative m,
      Show (m (b -> c)), Show (m (a -> b)), Show (m a), Show a) =>
     m (a, b, c) -> TestBatch

newtype Identity a =
  Identity a
  deriving (Eq,Show)

instance Functor (Identity) where
  fmap f (Identity a) = Identity (f a)

instance Applicative (Identity) where
  pure a = Identity a
  (<*>) (Identity f) a = fmap f a

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

main :: IO ()
--main = quickBatch $ applicative (undefined :: Identity (String,String,Integer))
main = quickBatch $ applicative (Identity ("b"::[Char], "w"::[Char], 1::Integer))

--reuse the pre existing eq
instance Eq a => EqProp (Identity a) where (=-=) = eq
```
