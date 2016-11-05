# Monads

### ""

| Monoid | Functor | Applicative (Monodial Functor) | Monads (Applicative Functor) |
| --- | --- | --- | --- |
| Mashing two values of the same type together via mappend | Function application over some structure leaving the structure undisturbed | Function and value both have structure, we have to mash the structure together and leave it intact | another way of applying functions over structure, with a couple of additional features |
| (<>) | (<$>) | (<*>) | >>= |

####
```haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
```
