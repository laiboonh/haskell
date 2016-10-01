{-# OPTIONS_GHC -Wall #-}

data Mood = Blah | Yay
instance Show Mood where
  show Blah = "1"
  show Yay  = "2"

data DayOfWeek = Mon | Tue | Wed | Thu | Fri | Sat | Sun
instance Eq DayOfWeek where
  (==) Mon Mon = True
  (==) Tue Tue = True
  (==) Wed Wed = True
  (==) Thu Thu = True
  (==) Fri Fri = True
  (==) Sat Sat = True
  (==) Sun Sun = True
  (==) _ _     = False

data Date = Date' DayOfWeek Int
instance Eq Date where
  (==) (Date' dayOfWeek dayOfMonth) (Date' dayOfWeek' dayOfMonth') =
    dayOfWeek == dayOfWeek' && dayOfMonth == dayOfMonth'

data Identity a = Identity' a
instance Eq a => Eq (Identity a) where
  (==) (Identity' v) (Identity' v') =
    v == v'
