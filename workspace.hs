{-# OPTIONS_GHC -Wall #-}

-- To find out if lists in list is all same length
sameLength :: [[a]] -> Bool
sameLength [] = False
sameLength (x:xs) = foldl step True xs
  where
    headLen = length x
    step acc e = acc && (length e == headLen)


data Mood = Blah | Yay
instance Show Mood where
  show Blah = "1"
  show Yay  = "2"
