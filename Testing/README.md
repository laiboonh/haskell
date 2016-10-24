# Testing

#### Generating random values
```haskell
λ> sample :: Show a => Gen a -> IO ()
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
