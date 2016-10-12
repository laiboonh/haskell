# List

#### List comprehensions will expand the right most generator first
```haskell
λ> [(x,y) | x<-[1,2,3], y<-[]]
[]
it :: Num t => [(t, t1)]
λ> [(x,y) | x<-[1,2,3], y<-[1]]    
[(1,1),(2,1),(3,1)]                
it :: (Num t1, Num t) => [(t, t1)]
```
