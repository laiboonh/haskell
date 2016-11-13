# Currying

#### Anonymous/Lambda Function
```haskell
greaterThan100 :: [Integer] -> [Integer]
greaterThan100 xs = filter (\x -> x > 100) xs
```

#### Operator Section
#### (>y) is equivalent to \x -> x > y. (y>) is equivalent to \x -> y > x.
```haskell
greaterThan100 :: [Integer] -> [Integer]
greaterThan100 xs = filter (>100) xs
```
```haskell
λ> let greaterThan100 xs = filter (>100) xs
λ> greaterThan100 [1,2,3]
[]
λ> let greaterThan100 xs = filter (100>) xs
λ> greaterThan100 [1,2,3]
[1,2,3]
```

#### Partial Function Application
```haskell
λ> let f x y = 2*x + y
f :: Num a => a -> a -> a
λ> let g = f 1
g :: Num a => a -> a
λ> g 10
12
```
#### function arrows associate to the right
```haskell
f :: Int -> (Int -> Int)
f x y = 2*x + y
```
#### function application associates to the left
```haskell
λ> (f 1) 10
12
--hence in this case we can do without brackets
λ> f 1 10
12
```
