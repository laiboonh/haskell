{-# OPTIONS_GHC -Wall #-}

module PoemLines where

firstSen :: String
firstSen = "Hello\n"

secondSen :: String
secondSen = "World\n"

sentence :: String
sentence = firstSen ++ secondSen

shouldEqual :: [String]
shouldEqual = ["Hello","World"]

main :: IO ()
main =
  print $ "Are they equal? " ++ show (myLines sentence == shouldEqual)


myLines :: String -> [String]
myLines x = go' x []
  where go' :: String -> [String] -> [String]
        go' [] acc = acc
        go' x' acc = go' ( dropWhile (\y -> y == '\n') (dropWhile ((\y -> y /= '\n')) x')) (acc ++ [takeWhile (\y -> y /= '\n') x'])
