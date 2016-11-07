# Monads

### ""

| Monoid | Functor | Applicative (Monodial Functor) | Monads (Applicative Functor) |
| --- | --- | --- | --- |
| Mashing two values of the same type together via mappend | Function application over some structure leaving the structure undisturbed | Function and value both have structure, we have to mash the structure together and leave it intact | Another way of applying functions over structure, with a couple of additional features |
| mappend (<>) | fmap (<$>) | ap (<*>) | bind (>>=) |

####
```haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a  
```

#### (>>) sequencing operator sequences two actions while discarding any resulting value of the first action.
```haskell
λ> putStrLn "Hello, " >> putStrLn "World!"
Hello,
World!
```

#### (>>=) bind
```haskell
import           Control.Monad (join)
bind :: Monad m => m a -> (a -> m b) -> m b
bind x f = join $ fmap f x
```

#### "do" as a sybtatic sugar
```haskell
bindingAndSequencing :: IO () bindingAndSequencing = do
putStrLn "name pls:"
name <- getLine
putStrLn ("y helo thar: " ++ name)

--de-sugared
bindingAndSequencing' :: IO () bindingAndSequencing' =
putStrLn "name pls:" >>
getLine >>=
\name -> putStrLn ("y helo thar: " ++ name)
```
