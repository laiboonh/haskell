{-# OPTIONS_GHC -Wall #-}
{-
bindExp :: Integer -> String
bindExp x = let x = 10; y = 5 in
  "the integer was: " ++ show x
  ++ " and y was: " ++ show y
-}
pal :: (Eq a) => [a] -> Bool
pal xs
  | xs == reverse xs = True
  | otherwise = False
