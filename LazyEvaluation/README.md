# Lazy Evaluation

#### Strict Evaluation
```haskell
f x y = x + 2
f 5 (29^35792) -- completely evaluate 5 and 29^35792 before passing the results to f. In the end f does not even make use of y.
```
#### Lazy Evaluation
```haskell
f x y = x + 2
f 5 (29^35792) -- second argument is packaged as a thunk without doing any actual computation. thunk is never used and garbage collected.
```
#### Pattern matching drives evaluation
```haskell
take :: Int -> [a] -> [a]
take n _      | n <= 0 =  []
take _ []              =  []
take n (x:xs)          =  x : take (n-1) xs
```
#### Expressions are only evaluated when pattern-matched only as far as necessary for the match to proceed, and no further!
```haskell
take 3 (repeat 7)
      { 3 <= 0 is False, so we proceed to the second clause, which
    needs to match on the second argument. So we must expand
    repeat 7 one step. }
= take 3 (7 : repeat 7)
      { the second clause does not match but the third clause
        does. Note that (3-1) does not get evaluated yet! }
= 7 : take (3-1) (repeat 7)
      { In order to decide on the first clause, we must test (3-1)
        <= 0 which requires evaluating (3-1). }
= 7 : take 2 (repeat 7)
      { 2 <= 0 is False, so we must expand repeat 7 again. }
= 7 : take 2 (7 : repeat 7)
      { The rest is similar. }
= 7 : 7 : take (2-1) (repeat 7)
= 7 : 7 : take 1 (repeat 7)
= 7 : 7 : take 1 (7 : repeat 7)
= 7 : 7 : 7 : take (1-1) (repeat 7)
= 7 : 7 : 7 : take 0 (repeat 7)
= 7 : 7 : 7 : []
```

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
