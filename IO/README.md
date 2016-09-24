# IO

#### To compile haskell file `stack ghc helloworld`
#### *main* has type of the last action in do block
#### <- is to take value out of IO action
#### Last action in a *do* block cannot be bound to a name, it has to be an action
```haskell
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", how are you?")
```

#### *return* makes an IO action out of some value (helloworld1.hs)
```haskell
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  if null name
    then
      return ()
    else do
      putStrLn ("Hey " ++ name ++ ", how are you?")
```

#### You can use *let* in *do* block
#### return **does not** cause IO *do* block to end in execution
```haskell
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  if null name
    then
      return ()
    else do
      let bigName = map toUpper name
      putStrLn ("Hey " ++ bigName ++ "! how are you?")
```

## Glossary
1. action : Something when performed will have a side effect
2. unit : empty tuple ()
3. IO () : IO action with a **result type** of unit
