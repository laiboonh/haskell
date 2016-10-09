# Lazy Evaluation

### Force Evaluation through Seq

### seq will always evaluate the first argument and return the second argument
```haskell
λ> :t seq
seq :: a -> b -> b
```

#### foldl will evaluate at the very end 1 + (2 + (3 + 0)) remembering each expression as thunks
#### foldl' will force evaluate every step of the way not remembering any thunks through the use of seq
```haskell
λ> :m +Data.List
λ> foldl (+) 0 [1..3]      
6                         
it :: (Num b, Enum b) => b
λ> foldl' (+) 0 [1..3]     
6                         
it :: (Num b, Enum b) => b
```

### foldl' expands as follows:
```haskell
let new = 1 + 2
in new `seq` foldl' (+) new [3]

let new = 3 + 3
in new `seq` foldl' (+) new []
```

#### There is a difference between cons cell and the value inside the cons cell
#### length will just evaluate the full structure of the list (*spine*)
```haskell
λ> let x = [1,2,undefined,3]         
x :: Num t => [t]                    
λ> let y = [1,2]++undefined++[3]        
y :: Num a => [a]                    
λ> length x                          
4                                    
it :: Int                            
λ> length y                          
*** Exception: Prelude.undefined     
```

#### take will traverse the spine *and* evaluate the value inside the cons cell
```haskell
λ> take 3 y
[1,2*** Exception: Prelude.undefined
λ> take 3 y
[1,2*** Exception: Prelude.undefined
```
