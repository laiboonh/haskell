{-# LANGUAGE ViewPatterns #-}
import           Test.QuickCheck
import           Test.QuickCheck.Function

{--
a :: [Int]
a = fmap (+1) $ read "[1]" :: [Int]

b :: Maybe [String]
b = (fmap.fmap) (++ "lol") (Just ["Hi,", "Hello"])

c :: Integer -> Integer
c = (*2) . (\x -> x - 2)

d :: Integer -> String
d = ((return '1' ++) . show) . (\x -> [x, 1..3])

e :: IO Integer
e =
  let
    ioi = readIO "1" :: IO Integer
    changed =  fmap read $ fmap ("123"++) $ fmap show ioi
  in fmap (*3) changed
--}

newtype Identity a = Identity a deriving (Eq,Show)
instance Functor (Identity) where
  fmap f (Identity a) = Identity (f a)
instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    a <- arbitrary
    return (Identity a)

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f
functorCompose :: (Functor f, Eq (f c)) => f a -> Fun a b -> Fun b c -> Bool
functorCompose x (Fun _ f) (Fun _ g) = (fmap (g . f) x) == (fmap g . fmap f $ x)

type IntToInt = Fun Int Int
type IdentityID = Identity Int -> Bool
type IdentityFC = Identity Int -> IntToInt -> IntToInt -> Bool

main :: IO ()
main = do
  quickCheck (functorIdentity :: IdentityID)
  quickCheck (functorCompose :: IdentityFC)
