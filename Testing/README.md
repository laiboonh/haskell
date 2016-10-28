# Testing

#### Generating random values
```haskell
λ> :t sample
sample :: Show a => Gen a -> IO ()
λ> sample (arbitrary :: Gen Int)
0
2
2
6
3
-8
2
1
11
14
10
```

#### Dictating the sample space for random value generation
```haskell
λ> :t return
return :: Monad m => a -> m a
λ> sample (return 1 :: Gen Int )
1
1
1
1
1
1
1
1
1
1
1
```

#### Generating random defined values
```haskell
λ> :t elements
elements :: [a] -> Gen a
λ> sample (elements [1,2,3] :: Gen Int)
1
2
2
1
1
1
3
1
2
3
3
```

#### Dictating the chances of a certain value appearing
```haskell
λ> :t frequency
frequency :: [(Int, Gen a)] -> Gen a
λ> sample $ frequency [(1, return 'A'), (3, return 'B')]
'A'
'B'
'B'
'B'
'B'
'B'
'B'
'B'
'B'
'B'
'B'
```

#### Generating tuples
```haskell
genTuple :: (Arbitrary a, Arbitrary b) => Gen (a,b)
genTuple = do
  a <- arbitrary
  b <- arbitrary
  return (a,b)

λ> sample (genTuple :: Gen(Int,Float))
(0,0.0)
(-2,-4.413058)
(2,-2.912873)
(-2,-0.72597295)
(6,2.4764097)
(-10,18.680439)
(-12,-91.8728)
(5,21.62951)
(-9,5.3449793)
(13,-3.0478463)
(0,-13.311042)
```
