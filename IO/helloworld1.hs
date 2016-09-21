{-# OPTIONS_GHC -Wall #-}
main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  if null name
    then
      return ()
    else do
      putStrLn ("Hey " ++ name ++ ", how are you?")
