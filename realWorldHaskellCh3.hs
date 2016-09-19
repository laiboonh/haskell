{-# OPTIONS_GHC -Wall #-}

-- BookInfo : type constructor
-- Book : value constructor
-- Int String [String] are components of the type
data BookInfo = Book Int String [String] deriving Show
data MagazineInfo = Magazine Int String [String] deriving Show

-- We use Book like a function
myInfo :: BookInfo
myInfo = Book 1 "foo" ["bar","baz"]

type CustomerId = Int
type ReviewBody = String
-- Type constructor and Value constructor can be of the same name
data BookReview = BookReview BookInfo CustomerId ReviewBody deriving Show

myBookReview :: BookReview
myBookReview = BookReview myInfo 1 "This is a good book"

-- Algebraic Data Type : has one or more value constructor
data Bool = False | True

type CardNumber = String
type CardHolder = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                  | CashOnDelivery
                  | Invoice CustomerId deriving Show

myBilling :: BillingInfo
myBilling = Invoice 1

-- How can we tell a BillingInfo is created by CreditCard CashOnDelivery or Invoice?
-- Pattern Matching
