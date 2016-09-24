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
    [input,output] -> let function = fixLines in interactWith function input output
    _              -> putStrLn "error: exactly two arguments needed"

fixLines :: String -> String
fixLines input = unlines (firstWord (splitLines input))

firstWord :: [String] -> [String]
firstWord []     = []
firstWord (x:xs) = head (words x) : firstWord xs

splitLines :: String -> [String]
splitLines [] = []
splitLines cs =
    let (prefix, suffix) = break isLineTerminator cs
    in  prefix : case suffix of
                ('\r':'\n':rest) -> splitLines rest
                ('\r':rest)      -> splitLines rest
                ('\n':rest)      -> splitLines rest
                _                -> []

isLineTerminator :: Char -> Bool
isLineTerminator c = c == '\r' || c == '\n'
