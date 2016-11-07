import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

data Sum a b =
  First a |
  Second b
  deriving (Eq, Show)

instance Functor (Sum a) where
  fmap _ (First a) = First a
  fmap f (Second b) = Second (f b)

instance Applicative (Sum a) where
  pure = Second
  (<*>) _ (First x) = First x
  (<*>) (First x) _ = First x
  (<*>) (Second f) (Second x) = Second (f x)

instance Monad (Sum a) where
  return = pure
  (>>=) (First x) _ = First x
  (>>=) (Second x) f = f x

instance (Arbitrary a, Arbitrary b) => Arbitrary (Sum a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [First a, Second b]

instance (Eq a, Eq b) => EqProp (Sum a b) where (=-=) = eq

main :: IO ()
main = do
  quickBatch $ monad (undefined :: Sum (String,String,Integer) (String,String,Integer))
