{-# OPTIONS_GHC -Wall #-}

import           Control.Monad (forever)
import           Data.Char     (toLower)
import           System.Exit   (exitSuccess)

palindrome :: IO ()
palindrome = forever $ do
  line1 <- getLine
  let processLn = filter (`elem` alpha)  (map toLower line1)
      alpha = ['a'..'z']
  if (processLn == reverse processLn)
    then
      putStrLn "It's a palindrome!"
    else
      do
        putStrLn $ "Nope!"
        exitSuccess

type Name = String
type Age = Integer

data Person = Person Name Age deriving Show
data PersonInvalid =
  NameEmpty |
  AgeTooLow |
  PersonInvalidUnknown String
  deriving (Eq,Show)

mkPerson :: Name -> Age -> Either PersonInvalid Person
mkPerson name age
    | name /= "" && age > 0 = Right $ Person name age
    | name == "" = Left NameEmpty
    | not (age > 0) = Left AgeTooLow
    | otherwise = Left $ PersonInvalidUnknown $ "Name was: " ++ show name ++ " Age was: " ++ show age

gimmePerson :: IO ()
gimmePerson = do
  putStr "Enter person name: "
  name <- getLine
  putStr "Age: "
  ageString <- getLine
  let age = (read ageString) :: Age
  case (mkPerson name age) of
    Left err -> putStrLn $ ("PersonInvalid: " ++ show err)
    Right person -> putStrLn ("Yay successfully got a person: " ++ show person)
