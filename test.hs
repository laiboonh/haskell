{-# OPTIONS_GHC -Wall    #-}

data Book =
  Book Int
       String
       [String]
  deriving Show

bookTitle :: Book -> String
bookTitle book = a
  where Book _ a _ = book

bookId :: Book -> Int
bookId (Book id' _ _) = id'

head' :: Num a => [a] -> a
head' (x:_) = x
head' _ = 0

type CustomerId = Int

type Address = [String]

data Customer =
  Customer {customerId      :: CustomerId
           ,customerName    :: String
           ,customerAddress :: Address}
  deriving Show

customer1 :: Customer
customer1 =
  Customer {customerId = 1
           ,customerName = "Bob"
           ,customerAddress = ["whoo","boo"]}

second :: [a] -> Maybe a
second (_:x:_) = Just x
second _ = Nothing
