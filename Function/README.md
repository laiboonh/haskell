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