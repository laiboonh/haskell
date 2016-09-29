# IO

To compile haskell file `stack ghc helloworld`

*main* has type of the last action in do block

<- is to take value out of IO action

Last action in a *do* block cannot be bound to a name, it has to be an action

```haskell
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", how are you?")
```

*return* makes an IO action out of some value

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

You can use *let* in *do* block

return **does not** cause IO *do* block to end in execution

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

#### *"You can see IO String as a means of producing a String" which causes side effect*

#### () is an empty tuple or *unit*. Unit is a value and also a type that means nothing
```haskell
λ: :i ()
data () = ()    -- Defined in ‘GHC.Tuple’
instance Bounded () -- Defined in ‘GHC.Enum’
instance Enum () -- Defined in ‘GHC.Enum’
instance Eq () -- Defined in ‘GHC.Classes’
instance Ord () -- Defined in ‘GHC.Classes’
instance Read () -- Defined in ‘GHC.Read’
instance Show () -- Defined in ‘GHC.Show’
instance Monoid () -- Defined in ‘GHC.Base’
```
