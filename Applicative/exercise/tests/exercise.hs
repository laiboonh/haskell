import           Control.Applicative
import           Data.Monoid
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

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



--2.
data Pair a =
  Pair a a
  deriving (Eq,Show)
instance Functor (Pair) where
  fmap f (Pair a1 a2) = Pair (f a1) (f a2)
instance Applicative (Pair) where
  pure x = Pair x x
  (<*>) (Pair f1 f2) (Pair x1 x2) = Pair (f1 x1) (f2 x2)

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = Pair <$> arbitrary <*> arbitrary
instance Eq a => EqProp (Pair a) where (=-=) = eq

--3.
data Two a b =
  Two a b
  deriving (Eq,Show)
instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = Two <$> arbitrary <*> arbitrary
instance Monoid a => Applicative (Two a) where
  pure x = Two mempty x
  (<*>) (Two a1 f) (Two a2 x) = Two (a1 <> a2) (f x)

instance (Eq a, Eq b) => EqProp (Two a b) where (=-=) = eq

--4.
data Three a b c =
  Three a b c
  deriving (Eq,Show)
instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)
instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = Three <$> arbitrary <*> arbitrary <*> arbitrary
instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure x = Three mempty mempty x
  (<*>) (Three a1 b1 f) (Three a2 b2 x) = Three (a1 <> a2) (b1 <> b2) (f x)

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where (=-=) = eq

--5.
data Three' a b =
  Three' a b b
  deriving (Eq,Show)
instance Functor (Three' a) where
  fmap f (Three' a b1 b2) = Three' a (f b1) (f b2)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = Three' <$> arbitrary <*> arbitrary <*> arbitrary
instance (Monoid a) => Applicative (Three' a) where
  pure x = Three' mempty x x
  (<*>) (Three' a1 f1 f2) (Three' a2 x1 x2) = Three' (a1 <> a2) (f1 x1) (f2 x2)

instance (Eq a, Eq b) => EqProp (Three' a b) where (=-=) = eq

--6.
data Four a b c d = Four a b c d deriving (Eq,Show)
instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)
instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = Four <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure x = Four mempty mempty mempty x
  (<*>) (Four a1 b1 c1 f) (Four a2 b2 c2 x) = Four (a1 <> a2) (b1 <> b2) (c1 <> c2) (f x)

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where (=-=) = eq

--7.
data Four' a b =
  Four' a a a b
  deriving (Eq,Show)
instance Functor (Four' a) where
  fmap f (Four' a1 a2 a3 b) = Four' a1 a2 a3 (f b)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = Four' <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary
instance (Monoid a) => Applicative (Four' a) where
  pure x = Four' mempty mempty mempty x
  (<*>) (Four' a1 a2 a3 f) (Four' a4 a5 a6 x) = Four' (a1 <> a4) (a2 <> a5) (a3 <> a6) (f x)

instance (Eq a, Eq b) => EqProp (Four' a b) where (=-=) = eq



main :: IO ()
main = do
  quickBatch $ applicative (undefined :: Identity (String,String,Integer))
  quickBatch $ applicative (undefined :: Pair (String,String,Integer))
  quickBatch $ applicative (undefined :: (Two String (String,String,Integer)))
  quickBatch $ applicative (undefined :: (Three String String (String,String,Integer)))
  quickBatch $ applicative (undefined :: (Three' String (String,String,Integer)))
  quickBatch $ applicative (undefined :: (Four String String String (String,String,Integer)))
  quickBatch $ applicative (undefined :: (Four' String (String,String,Integer)))

stops, vowels :: String
stops = "pbtdkg"
vowels = "aeiou"
combos :: [a] -> [b] -> [c] -> [(a, b, c)]
combos x y z = liftA3 (,,) x y z
