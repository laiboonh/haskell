{-# LANGUAGE ViewPatterns #-}
import           Test.QuickCheck
import           Test.QuickCheck.Function

--1.
newtype Identity a = Identity a deriving (Eq,Show)
instance Functor (Identity) where
  fmap f (Identity a) = Identity (f a)
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f
functorCompose :: (Functor f, Eq (f c)) => f a -> Fun a b -> Fun b c -> Bool
functorCompose x (Fun _ f) (Fun _ g) = (fmap (g . f) x) == (fmap g . fmap f $ x)

type IntToInt = Fun Int Int
type IdentityID = Identity Int -> Bool
type IdentityFC = Identity Int -> IntToInt -> IntToInt -> Bool

--2.
data Pair a = Pair a a deriving (Eq,Show)
instance Functor (Pair) where
  fmap f (Pair a1 a2) = Pair (f a1) (f a2)
instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = do
    a1 <- arbitrary
    a2 <- arbitrary
    return (Pair a1 a2)
type PairID = Pair Int -> Bool
type PairFC = Pair Int -> IntToInt -> IntToInt -> Bool

--3.
data Two a b = Two a b deriving (Eq,Show)
instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)
type TwoID = Two Int Int -> Bool
type TwoFC = Two Int Int -> IntToInt -> IntToInt -> Bool

--4.
data Three a b c = Three a b c deriving (Eq,Show)
instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)
instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)
type ThreeID = Three Int Int Int -> Bool
type ThreeFC = Three Int Int Int -> IntToInt -> IntToInt -> Bool

--5.
data Three' a b = Three' a b b deriving (Eq,Show)
instance Functor (Three' a) where
  fmap f (Three' a b1 b2) = Three' a (f b1) (f b2)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = do
    a <- arbitrary
    b1 <- arbitrary
    b2 <- arbitrary
    return (Three' a b1 b2)
type Three'ID = Three' Int Int -> Bool
type Three'FC = Three' Int Int -> IntToInt -> IntToInt -> Bool

--6.
data Four a b c d = Four a b c d deriving (Eq,Show)
instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)
instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)
type FourID = Four Int Int Int Int -> Bool
type FourFC = Four Int Int Int Int -> IntToInt -> IntToInt -> Bool

--7.
data Four' a b = Four' a a a b deriving (Eq,Show)
instance Functor (Four' a) where
  fmap f (Four' a1 a2 a3 b) = Four' a1 a2 a3 (f b)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    a1 <- arbitrary
    a2 <- arbitrary
    a3 <- arbitrary
    b <- arbitrary
    return (Four' a1 a2 a3 b)
type Four'ID = Four' Int Int -> Bool
type Four'FC = Four' Int Int -> IntToInt -> IntToInt -> Bool

main :: IO ()
main = do
  quickCheck (functorIdentity :: IdentityID)
  quickCheck (functorCompose :: IdentityFC)
  quickCheck (functorIdentity :: PairID)
  quickCheck (functorCompose :: PairFC)
  quickCheck (functorIdentity :: TwoID)
  quickCheck (functorCompose :: TwoFC)
  quickCheck (functorIdentity :: ThreeID)
  quickCheck (functorCompose :: ThreeFC)
  quickCheck (functorIdentity :: Three'ID)
  quickCheck (functorCompose :: Three'FC)
  quickCheck (functorIdentity :: FourID)
  quickCheck (functorCompose :: FourFC)
  quickCheck (functorIdentity :: Four'ID)
  quickCheck (functorCompose :: Four'FC)
