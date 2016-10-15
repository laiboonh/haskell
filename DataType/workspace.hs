{-# OPTIONS_GHC -Wall #-}

data FlowerType = Gardenia | Daisy | Rose | Lilac deriving Show
type Gardener = String
data Garden = Garden Gardener FlowerType deriving Show

data Gardenia = Gardenia' deriving Show
data Daisy = Daisy' deriving Show
data Rose = Rose' deriving Show
data Lilac = Lilac' deriving Show
data Garden' = Garden' Gardener Gardenia deriving Show

data GuessWhat = Chickenbutt deriving (Eq,Show) -- type and data nullary constructors
data Id a = MkId a deriving (Eq,Show)-- type and data unary constructors, Id is sum type
data Product a b = Product a b deriving (Eq,Show) -- type and data binary constructors, Product is product type
data Sum a b = First a | Second b deriving (Eq,Show) -- Sum is sum type with 2 data constructors
data RecordProduct a b =
  RecordProduct {
    pfirst  :: a,
    psecond :: b
  } deriving (Eq,Show)


newtype NumCow =
  NumCow Int
  deriving (Eq,Show)

newtype NumPig =
  NumPig Int
  deriving (Eq,Show)

data Farmhouse =
  Farmhouse NumCow NumPig
  deriving (Eq,Show)

idInt :: Num a => Id a
idInt = MkId 10

type Name = String
type Awesome = Bool
person :: Product Name Awesome
person = Product "Simon" True

data Twitter = Twitter deriving (Eq,Show)
data AskFm = AskFm deriving (Eq,Show)
socialNetwork :: Sum Twitter AskFm
socialNetwork = First Twitter

myRecord :: RecordProduct Int Float
myRecord = RecordProduct {
  pfirst = 42,
  psecond = 0.01
}

data OperatingSystem =
  GnuPlusLinux |
  OpenBSDPlusNevermindJustBSDStill |
  Mac |
  Windows
  deriving (Eq,Show)

data ProgrammingLanguage =
  Haskell |
  Agda |
  Idris |
  Purescript
  deriving (Eq,Show)

data Programmer =
  Programmer {
    os   :: OperatingSystem,
    lang :: ProgrammingLanguage
  } deriving (Eq,Show)

allOperatingSystems :: [OperatingSystem]
allOperatingSystems =
  [
    GnuPlusLinux,
    OpenBSDPlusNevermindJustBSDStill,
    Mac,
    Windows
  ]

allLanguages :: [ProgrammingLanguage]
allLanguages =
  [
    Haskell,
    Agda,
    Idris,
    Purescript
  ]

allProgrammers :: [Programmer]
allProgrammers = [Programmer x y | x <- allOperatingSystems, y <- allLanguages]
