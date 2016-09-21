{-# OPTIONS_GHC -Wall #-}
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  putStrLn ("Hey " ++ name ++ ", how are you?")
