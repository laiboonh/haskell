# Function

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
