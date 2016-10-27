import           Data.Semigroup
import           Test.QuickCheck (Arbitrary,arbitrary,quickCheck,elements)

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

--8.
data Or a b =
  Fst a |
  Snd b
  deriving (Eq,Show)
instance Semigroup (Or a b) where
  Fst _ <> Snd y = Snd y
  Snd x <> _ = Snd x
  Fst _ <> Fst y = Fst y
instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(Fst a),(Snd b)]
type OrAssoc = Or String String -> Or String String  -> Or String String -> Bool

--9.
newtype Combine a b =
  Combine { unCombine :: (a -> b) }
instance Semigroup b => Semigroup (Combine a b) where
  Combine {unCombine=f} <> Combine {unCombine=g} = Combine {unCombine=(f <> g)}

--10.
newtype Comp a =
  Comp {unComp :: (a->a)}
instance Semigroup a => Semigroup (Comp a) where
  Comp {unComp=f} <> Comp {unComp=g} = Comp {unComp=(f <> g)}

--11.
data Validation a b =
  Failure a |
  Success b
  deriving (Eq,Show)
instance Semigroup a => Semigroup (Validation a b) where
  (Failure a) <> (Failure b)  = Failure (a <> b)
  (Failure a) <> _            = Failure a
  _           <> (Failure a)  = Failure a
  a           <> _            = a
instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [(Failure a), (Success b)]
type ValidationAssoc = Validation String String -> Validation String String  -> Validation String String -> Bool

--12.
newtype AccumulateRight a b =
  AccumulateRight (Validation a b)
  deriving (Eq,Show)
instance Semigroup b => Semigroup (AccumulateRight a b) where
  (AccumulateRight (Success b1)) <> (AccumulateRight (Success b2)) = AccumulateRight (Success (b1<>b2))
  (AccumulateRight (Success b)) <> _ = AccumulateRight (Success b)
  _ <> (AccumulateRight (Success b)) = AccumulateRight (Success b)
  a <> _ = a
instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateRight a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [AccumulateRight (Success a),AccumulateRight (Failure b)]
type AccumulateRightAssoc = AccumulateRight String String -> AccumulateRight String String  -> AccumulateRight String String -> Bool

--13.
newtype AccumulateBoth a b =
  AccumulateBoth (Validation a b)
  deriving (Eq,Show)
instance (Semigroup a, Semigroup b) => Semigroup (AccumulateBoth a b) where
  (AccumulateBoth (Success x)) <> (AccumulateBoth (Success y)) = AccumulateBoth (Success (x<>y))
  (AccumulateBoth (Failure y1)) <> (AccumulateBoth (Failure y2)) = AccumulateBoth (Failure (y1<>y2))
  (AccumulateBoth (Failure y)) <> _ = AccumulateBoth (Failure (y))
  _ <> (AccumulateBoth (Failure y)) = AccumulateBoth (Failure (y))
instance (Arbitrary a, Arbitrary b) => Arbitrary (AccumulateBoth a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [AccumulateBoth (Success a),AccumulateBoth (Failure b)]
type AccumulateBothAssoc = AccumulateBoth String String -> AccumulateBoth String String  -> AccumulateBoth String String -> Bool


main :: IO ()
main = do
  quickCheck (semigroupAssoc :: TrivialAssoc)
  quickCheck (semigroupAssoc :: IdentityAssoc)
  quickCheck (semigroupAssoc :: TwoAssoc)
  quickCheck (semigroupAssoc :: ThreeAssoc)
  quickCheck (semigroupAssoc :: FourAssoc)
  quickCheck (semigroupAssoc :: BoolConjAssoc)
  quickCheck (semigroupAssoc :: BoolDisjAssoc)
  quickCheck (semigroupAssoc :: OrAssoc)
  quickCheck (semigroupAssoc :: ValidationAssoc)
  quickCheck (semigroupAssoc :: AccumulateRightAssoc)
  quickCheck (semigroupAssoc :: AccumulateBothAssoc)
