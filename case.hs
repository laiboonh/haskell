{-# OPTIONS_GHC -Wall    #-}

getValue :: a -> Maybe a -> a
getValue defValue wrapped = case wrapped of
  Just value -> value
  Nothing -> defValue
