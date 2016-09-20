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
-- How can we tell a BillingInfo is created by CreditCard CashOnDelivery or Invoice?
-- Pattern Matching
sumList :: (Num a) => [a] -> a
sumList (x:xs) = x + sumList(xs)
sumList []     = 0

-- Record syntax
data Customer = Customer {
  customerId        :: CustomerId
  , customerName    :: String
  , customerAddress :: Address
} deriving Show

myCustomer :: Customer
myCustomer = Customer {
  customerId = 1
  ,customerName = "foo"
  ,customerAddress = ["bar","baz"]
}

-- Parameterized Type
-- a : type variable
data Maybe' a = Just' a | Nothing' deriving Show
someInt :: Maybe' Int
someInt = Just' 1

-- Recursive Type
data List a = Cons a (List a) | Nil deriving Show
myList :: List Int
myList = Cons 1 (Cons 2 Nil)

fromList :: [a] -> List a
fromList (x:xs) = Cons x (fromList xs)
fromList []     = Nil

fromList' :: List a -> [a]
fromList' (Cons x xs) = x : (fromList' xs)
fromList' Nil         = []

data Tree a = Node a (Maybe (Tree a)) (Maybe (Tree a)) deriving Show
myTree :: Tree Int
myTree = Node 1 (Just(Node 2 (Nothing) (Nothing))) (Nothing)

-- Let-If block declare local variables
lend :: (Num a, Ord a) => a -> a -> Maybe a
lend amount balance = let reserve = 100
                          newBalance = balance - amount
                      in if balance < reserve
                          then Nothing
                          else Just newBalance

-- where clause local variables
lend2 :: (Num a, Ord a) => a -> a -> Maybe a
lend2 amount balance = if balance < reserve
                          then Nothing
                          else Just newBalance
                       where
                          reserve = 100
                          newBalance = balance - amount

-- where caluse define local functions
pluralise :: String -> [Int] -> [String]
pluralise word counts = map plural counts
  where plural 0 = "no " ++ word ++ "s"
        plural 1 = "one " ++ word
        plural n = show n ++ " " ++ word ++ "s"


-- case expression
fromMaybe :: a -> Maybe a -> a
fromMaybe defval wrapped =
  case wrapped of
    Nothing    -> defval
    Just value -> value

-- guards
lend3 :: (Num a, Ord a) => a -> a -> Maybe a
lend3 amount balance
  | amount <= 0 = Nothing
  | amount > reserve = Nothing
  | otherwise = Just newBalance
  where reserve = 100
        newBalance = balance - amount
