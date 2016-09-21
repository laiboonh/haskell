{-# OPTIONS_GHC -Wall #-}
import           Data.Char

main :: IO ()
main = do
  putStrLn "Hello, what's your name?"
  name <- getLine
  if null name
    then
      return ()
    else do
      let bigName = map toUpper name
      putStrLn ("Hey " ++ bigName ++ "! how are you?")
