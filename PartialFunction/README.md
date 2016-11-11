# Partial and Total Function

#### Partial Function only return values for a subset of valid inputs
```haskell
head :: [a] -> a
head (x:xs) = x
```

#### Total Function return values for the entire input domain  
```haskell
length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs  
```

#### How to deal with Partial Functions?
#### 1. Change the type of the output to indicate the possible failure. Let the types tell us the behaviour of the functions
```haskell
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x
```
#### 2. If we know that certain cases are guaranteed not to happen e.g. empty list. Show it using the types!
```haskell
data NonEmptyList a = NEL a [a]

nelToList :: NonEmptyList a -> [a]
nelToList (NEL x xs) = x:xs

listToNel :: [a] -> Maybe (NonEmptyList a)
listToNel []     = Nothing
listToNel (x:xs) = Just $ NEL x xs

headNEL :: NonEmptyList a -> a
headNEL (NEL a _) = a

tailNEL :: NonEmptyList a -> [a]
tailNEL (NEL _ as) = as
```
