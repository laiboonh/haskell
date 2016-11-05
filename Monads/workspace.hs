{-# OPTIONS_GHC -Wall #-}

import Control.Monad

bind :: Monad m => (a -> m b) -> m a -> m b
bind f x = join $ fmap f x
