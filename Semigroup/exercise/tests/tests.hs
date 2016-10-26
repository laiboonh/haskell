import           Data.Semigroup
import           Test.QuickCheck

--1.
data Trivial =
  Trivial
  deriving (Eq, Show)

instance Semigroup Trivial where
  _ <> _ = Trivial
instance Arbitrary Trivial where
  arbitrary = return Trivial

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

type TrivialAssoc = Trivial -> Trivial -> Trivial -> Bool

--2.
newtype Identity a =
  Identity a
  deriving (Eq, Show)
instance (Semigroup a) => Semigroup (Identity a) where
  (Identity x1) <> (Identity x2) = Identity (x1 <> x2)
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)
type IdentityAssoc = Identity String -> Identity String -> Identity String -> Bool

--3.
data Two a b =
  Two a b
  deriving (Eq, Show)
instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (Two x1 y1) <> (Two x2 y2) = Two (x1<>x2) (y1<>y2)
instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)
type TwoAssoc = Two String String -> Two String String -> Two String String -> Bool

--4.
data Three a b c =
  Three a b c
  deriving (Eq, Show)
instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
  (Three x1 y1 z1) <> (Three x2 y2 z2) = Three (x1<>x2) (y1<>y2) (z1<>z2)
instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)
type ThreeAssoc = Three String String String -> Three String String String -> Three String String String -> Bool

--5.
data Four a b c d =
  Four a b c d
  deriving (Eq, Show)
instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
  (Four x1 y1 z1 q1) <> (Four x2 y2 z2 q2) = Four (x1<>x2) (y1<>y2) (z1<>z2) (q1<>q2)
instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    d <- arbitrary
    return (Four a b c d)
type FourAssoc = Four String String String String -> Four String String String String -> Four String String String String -> Bool

--6.
newtype BoolConj =
  BoolConj Bool deriving (Eq,Show)
instance Semigroup BoolConj where
  (BoolConj b1) <> (BoolConj b2) = BoolConj (b1 && b2)
instance Arbitrary BoolConj where
  arbitrary = do
    a <- arbitrary
    (elements [BoolConj a, BoolConj a])
type BoolConjAssoc = BoolConj -> BoolConj  -> BoolConj -> Bool

--7.
newtype BoolDisj =
  BoolDisj Bool deriving (Eq,Show)
instance Semigroup BoolDisj where
  (BoolDisj b1) <> (BoolDisj b2) = BoolDisj (b1 || b2)
instance Arbitrary BoolDisj where
  arbitrary = do
    a <- arbitrary
    (elements [BoolDisj a, BoolDisj a])
type BoolDisjAssoc = BoolDisj -> BoolDisj  -> BoolDisj -> Bool




main :: IO ()
main = do
  quickCheck (semigroupAssoc :: TrivialAssoc)
  quickCheck (semigroupAssoc :: IdentityAssoc)
  quickCheck (semigroupAssoc :: TwoAssoc)
  quickCheck (semigroupAssoc :: ThreeAssoc)
  quickCheck (semigroupAssoc :: FourAssoc)
  quickCheck (semigroupAssoc :: BoolConjAssoc)
  quickCheck (semigroupAssoc :: BoolDisjAssoc)
