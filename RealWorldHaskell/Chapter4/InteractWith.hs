{-# OPTIONS_GHC -Wall #-}

import           System.Environment (getArgs)

interactWith :: (String -> String) -> FilePath -> FilePath -> IO ()
interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [input,output] -> let function = id in interactWith function input output
    _              -> putStrLn "error: exactly two arguments needed"
