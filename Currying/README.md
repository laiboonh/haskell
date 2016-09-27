# Currying

#### Lambda Function
```haskell
isInAny :: String -> [String] -> Bool
isInAny needle haystack = any (\s -> needle `isInfixOf` s) haystack
```

#### Partial Function Application
```haskell
isInAny :: String -> [String] -> Bool
isInAny needle haystack = any (isInfixOf needle) haystack
```

#### Sections
```haskell
isInAny :: String -> [String] -> Bool
isInAny needle haystack = any (needle `isInfixOf`) haystack
```
