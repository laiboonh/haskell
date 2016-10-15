# List

#### Definition
#### Any operator that starts with a colon (:) must be an infix type or data constructor
```haskell
data [] a = [] | a : [a] -- (:) is data constructor
λ> let empty = []
empty :: [t] -- the type parameter is not applied because it's not possible to infer what the list contains from []

data List a = Nil | Cons a (List a)
λ> :k List
List :: * -> *
λ> :k List Int
List Int :: *
```

#### List comprehensions will expand the right most generator first
```haskell
λ> [(x,y) | x<-[1,2,3], y<-[]]
[]
it :: Num t => [(t, t1)]
λ> [(x,y) | x<-[1,2,3], y<-[1]]    
[(1,1),(2,1),(3,1)]                
it :: (Num t1, Num t) => [(t, t1)]
```

#### Recursive function evaluation
```haskell
scanl :: (a -> b -> a) -> a -> [b] -> [a]
scanl f q ls =
  q : (case ls of
        [] -> []
        x:xs -> scanl f (f q x) xs)

fibs = 1 : scanl (+) 1 fibs
     = 1 : scanl (+) 1 (1 : scanl (+) 1 fibs)     
     = 1 : scanl (+) 1 (1 : scanl (+) 1 (1 : scanl (+) 1 fibs))      
     = 1 : scanl (+) 1 (1 : scanl (+) 1 (1 : scanl (+) 1 [1,?,?,..] ) )   --we can deduce that the result of fibs is something like [1,?,?,..]
     = 1 : scanl (+) 1 (1 : scanl (+) 1 (1 : [1, 2, ?, ?, ..]) )  --evaluate from inside out
     = 1 : scanl (+) 1 (1 : scanl (+) 1 [1, 1, 2, ?, ?, .. ] )
     = 1 : scanl (+) 1 (1 : [1, 2, 3, 5, ?,?, ..])
     = 1 : scanl (+) 1 [1, 1, 2, 3, 5, ?, ?, ..]
     = 1 : [1, 2, 3, 5, 8, 13, ?, ?, ..]
     = [1, 1, 2, 3, 5, 8, 13, ?, ?, ..]
```
