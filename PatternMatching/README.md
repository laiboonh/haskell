# Pattern Matching

## as
```haskell
firstLetter :: String -> String
firstLetter "" = "Empty String"
firstLetter str@(x:_) = "The first letter of " ++ str ++ " is " ++ [x]
```

## guards
