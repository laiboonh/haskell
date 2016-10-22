{-# OPTIONS_GHC -Wall #-}

module Cipher where

import           Data.Char
import           Data.List (findIndex, group, nub, sort)

ordFirst :: Int
ordFirst = ord 'A'

ordLast :: Int
ordLast = ord 'Z'

shiftRight :: Int -> Char -> Char
shiftRight i x =
  case expr > ordLast of
    True -> chr $ (ordFirst-1) + (expr - ordLast)
    False -> chr $ expr
    where expr = (ord x) + i

shiftAmt :: Char -> Int
shiftAmt = (`mod` 65).ord

caesar :: String -> String -> String -> String
caesar [] _ acc = reverse acc
caesar _ [] _ = []
caesar (x:xs) (y:ys) acc
  | x == ' ' = caesar xs (y:ys) ((shiftRight 0 x) : acc)
  | otherwise = caesar xs ys ((shiftRight (shiftAmt y) x) : acc)

type Message = String
type Key = String
type Cipher = String
vig :: Message -> Key -> Cipher
vig message key = caesar message (cycle key) []

main :: IO String
main = do
  putStr "Enter your message: "
  message <- getLine
  putStr "Enter your key: "
  key <- getLine
  return ("This is your cipher " ++ vig message key)



isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf lxs@(x:xs) (y:ys)
  | x == y = isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf lxs ys

capitalizeWords :: String -> [(String,String)]
capitalizeWords "" = []
capitalizeWords xs = map mkTuple (words xs)
  where mkTuple wd@(c:cs) = (wd, (toUpper c):cs)
        mkTuple [] = error "mkTuple empty string"

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = (toUpper x):xs

capitalizeParagraph :: String -> String
capitalizeParagraph [] = []
capitalizeParagraph xs = unsentence $ map capitalizeSentence (sentence xs)

sentence :: String -> [String]
sentence xs = reverse $ go [] xs
  where go :: [String] -> String -> [String]
        go acc [] = acc
        go acc xs' = go (first : acc) rest
                     where first = takeWhile (/='.') xs
                           rest = drop 2 (dropWhile (/='.') xs')

unsentence :: [String] -> String
unsentence [] = []
unsentence xs = init $ foldr (\x acc -> x ++ ". " ++ acc) [] xs

capitalizeSentence :: String -> String
capitalizeSentence [] = []
capitalizeSentence xs = (capitalizeWord (head w)) ++ (' ' : (unwords $ tail w))
  where w = words xs

myPhone :: Phone
myPhone =
  [
    ['1'],
    ['a','b','c','2'],
    ['d','e','f','3'],
    ['g','h','i','4'],
    ['j','k','l','5'],
    ['m','n','o','6'],
    ['p','q','r','s','7'],
    ['t','u','v','8'],
    ['w','x','y','z','9'],
    ['+', ' ', '0'],
    ['^', '*'],
    ['.',',','#']
  ]

type Phone = [Keys]
type Keys = [Char]
type Digit = Char
type Presses = Int

reverseTaps :: Phone -> Char -> [(Digit,Presses)]
reverseTaps [] c = error ("Illegal Digit " ++ [c])
reverseTaps (k:ks) c =
  case findIndex (==lowC) k of
    Just i -> if (toUpper c == c) then [('*',1),((last k),(i+1))] else [((last k),(i+1))]
    Nothing -> reverseTaps ks c
  where lowC = toLower c

cellPhonesDead :: Phone -> String -> [(Digit,Presses)]
cellPhonesDead p s = foldr ((++) . (reverseTaps p)) [] s

fingerTaps :: [(Digit,Presses)] -> Presses
fingerTaps [] = 0
fingerTaps xs = foldr ((+) . snd) 0 xs

mostPopularLetter :: String -> Char
mostPopularLetter "" = error "Empty String"
mostPopularLetter s =
  case findIndex (==maxCount) counts of
    Just i -> chars !! i
    Nothing -> error "Not possible"
    where groupedStr = group $ sort $ map toLower s
          counts = map length groupedStr
          chars = map (head .nub) groupedStr
          maxCount = maximum counts

convo :: [String]
convo =
    ["Wanna play 20 questions",
     "Ya",
     "U 1st haha",
     "Lol ok. Have u ever tasted alcohol lol",
     "Lol ya",
     "Wow ur cool haha. Ur turn",
     "Ok. Do u think I am pretty Lol",
     "Lol ya",
     "Haha thanks just making sure rofl ur turn"]

coolestLtr :: [String] -> Char
coolestLtr = mostPopularLetter . concat . concat . (map words)

data Expr =
  Lit Integer
  | Add Expr Expr

eval :: Expr -> Integer
eval (Lit i) = i
eval (Add e1 e2) = (eval e1) + (eval e2)

printExpr :: Expr -> String
printExpr (Lit i) = show i
printExpr (Add e1 e2) = printExpr e1 ++ " + " ++ printExpr e2
