{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE FlexibleInstances #-}

{-
a :: [Int]
a = fmap (+1) $ read "[1]" :: [Int]

b :: Maybe [String]
b = (fmap.fmap) (++ "lol") (Just ["Hi,", "Hello"])

c :: Integer -> Integer
c = (*2) . (\x -> x - 2)

d :: Integer -> String
d = ((return '1' ++) . show) . (\x -> [x, 1..3])

e :: IO Integer
e =
  let
    ioi = readIO "1" :: IO Integer
    changed =  fmap read $ fmap ("123"++) $ fmap show ioi
  in fmap (*3) changed
-}

data Sum b a =
  First a |
  Second b
instance Functor (Sum e) where
  fmap f (First a) = First (f a)
  fmap _ (Second b) = Second b

data Company a c b =
  DeepBlue a c |
  Something b
instance Functor (Company e e') where
  fmap f (Something b) = Something (f b)
  fmap _ (DeepBlue a c) = DeepBlue a c

data More b a =
  L a b a |
  R b a b
  deriving (Eq, Show)
instance Functor (More b) where
  fmap f (L a b a') = L (f a) b (f a')
  fmap f (R b a b') = R b (f a) b'

--1.
data Quant a b =
  Finance |
  Desk a |
  Bloor b
  deriving (Eq,Show)
instance Functor (Quant a) where
  fmap _ Finance = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor (f b)
{-
--2.
data K a b =
  K a
  deriving (Eq,Show)
instance Functor (K a) where
  fmap _ (K a) = K a
-}
--3.
newtype Flip f a b =
  Flip (f b a)
  deriving (Eq, Show)
newtype K a b =
  K a
  deriving (Eq, Show)
instance Functor (Flip K a) where
  fmap f (Flip (K a)) = Flip (K (f a))

--4.
data EvilGoateeConst a b =
  GoatyConst b
instance Functor (EvilGoateeConst a) where
  fmap f (GoatyConst b) = GoatyConst (f b)

--5.
data LiftItOut f a =
  LiftItOut (f a)
  deriving (Eq,Show)
instance Functor f => Functor (LiftItOut f) where
  fmap f (LiftItOut fa) = LiftItOut (fmap f fa)

--6.
data Parappa f g a =
  DaWrappa (f a) (g a)
  deriving (Eq,Show)
instance (Functor f,Functor g) => Functor (Parappa f g) where
  fmap f (DaWrappa fa ga) = DaWrappa (fmap f fa) (fmap f ga)

--7.
data IgnoreOne f g a b =
  IgnoringSomething (f a) (g b)
  deriving (Eq,Show)
instance Functor g => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething (fa) (gb)) = IgnoringSomething (fa) (fmap f gb)

--8.
data Notorious g o a t =
  Notorious (g o) (g a) (g t)
instance Functor g => Functor (Notorious g o a) where
  fmap f (Notorious (go) (ga) (gt)) = Notorious (go) (ga) (fmap f gt)

--9.
data List a =
  Nil |
  Cons a (List a)
instance Functor (List) where
  fmap _ Nil = Nil
  fmap f (Cons a as) = Cons (f a) (fmap f as)

--10.
data GoatLord a =
  NoGoat |
  OneGoat a |
  MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor (GoatLord) where
  fmap _ NoGoat = NoGoat
  fmap f (OneGoat a) = OneGoat (f a)
  fmap f (MoreGoats g1 g2 g3) = MoreGoats (fmap f g1) (fmap f g2) (fmap f g3)

--11.
data TalkToMe a =
  Halt |
  Print String a |
  Read (String -> a)
instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s (f a)
  fmap f (Read sa) = Read (fmap f sa)
