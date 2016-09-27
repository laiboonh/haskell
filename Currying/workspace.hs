{-# OPTIONS_GHC -Wall #-}

import Data.List (isInfixOf)
-- Lambda function
isInAny :: String -> [String] -> Bool
isInAny needle haystack = any (\s -> needle `isInfixOf` s) haystack
