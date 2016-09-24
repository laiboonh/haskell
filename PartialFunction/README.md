# Partial and Total Function

### Partial Function only return values for a subset of valid inputs
```haskell
head' :: [a] -> a
head' [] = error "empty list"
head' (x:xs) = x
```

### Total Function return values for the entire input domain  
```haskell
length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs  
```
