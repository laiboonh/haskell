module Hello where

sayHello :: String -> IO ()
sayHello name = putStrLn (mappend ("Hi ",name,"!"))
