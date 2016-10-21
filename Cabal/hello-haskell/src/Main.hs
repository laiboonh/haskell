module Main where

import System.IO
import qualified Hello as H

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  putStr "Please input your name: "
  name <- getLine
  H.sayHello name
