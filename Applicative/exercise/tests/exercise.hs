import Control.Applicative
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

--1.
newtype Identity a =
  Identity a
  deriving (Eq,Show)

instance Functor (Identity) where
  fmap f (Identity a) = Identity (f a)

instance Applicative (Identity) where
  pure a = Identity a
  (<*>) (Identity f) a = fmap f a

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

instance Eq a => EqProp (Identity a) where (=-=) = eq

main :: IO ()
main = quickBatch $ applicative (undefined :: Identity(String,String,Integer))
