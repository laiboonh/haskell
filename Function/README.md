# Function
### "Functions are applied to their arguments, and arguments are passed to functions and then evaluated to produce the output"

###Function Composition

#### As long as the types match up we can compose two functions
```haskell
λ> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c
λ> :t length
length :: Foldable t => t a -> Int
λ> :t words
words :: String -> [String]
λ> let numberOfWords = length . words
numberOfWords :: String -> Int
λ> numberOfWords "hello world"
2
```
#### This won't compile because it of precedence
```haskell
λ> negate . sum [1,2,3]
```
#### Function application precedence is 10, function composition precendence is 9
```haskell
λ> :i .
(.) :: (b -> c) -> (a -> b) -> a -> c   -- Defined in ‘GHC.Base’
infixr 9 .
```
#### `negate . sum [1,2,3]` will become `negate . 6` which won't compile because (.) expects 2 function arguments
#### Hence we use $
```haskell
λ> :i $
($) ::
  forall (r :: GHC.Types.RuntimeRep) a (b :: TYPE r).
  (a -> b) -> a -> b
        -- Defined in ‘GHC.Base’
infixr 0 $
λ> negate . sum $ [1,2,3]
-6
it :: Num c => c
```

#### *let* variables are only in scope inside the *let* expression. The following won't compile
```haskell
bindExp :: Integer -> String
bindExp x = let z = y + x in
  let y = 5 in "the integer was: "
    ++ show x ++ "and y was: "
    ++ show y ++ " and z was: "
    ++ show z
```

#### Shadowing
```haskell
bindExp :: Integer -> String
bindExp x = let x = 10; y = 5 in
  "the integer was: " ++ show x
  ++ " and y was: " ++ show y
```

#### Case expression. Expression means it returns an output.
```haskell
num :: (Ord a, Num a) => a -> a
num x =
  case compare x 0 of
    LT -> -1
    GT -> 1
    _ -> 0
```

#### Guard block
```haskell
pal :: (Eq a) => [a] -> Bool
pal xs
  | xs == reverse xs = True
  | otherwise = False
--otherwise is a synonym for True
λ> otherwise
True
it :: Bool  
```

#### "Kinds are the types of type constructors, primarily encoding the number of arguments they take."
```haskell
λ> :k Bool
Bool :: *
λ> :m +Data.List.NonEmpty
λ> :k NonEmpty
NonEmpty :: * -> *
λ> :i NonEmpty
data NonEmpty a = a :| [a]
```

#### "Each argument and result of every function must be a type constant not a type constructor"
```haskell
λ> :k (->)
(->) :: * -> * -> *
--Therefore f must accept a single type argument and be of the kind * -> *
λ> :t fmap
fmap :: Functor f => (a -> b) -> f a -> f b

```
