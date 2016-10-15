# DataType

#### Different ways of defining value constructors
```haskell
data GuessWhat = Chickenbutt deriving (Eq,Show) -- type and data nullary constructors
data Id a = MkId a deriving (Eq,Show) -- type and data unary constructors, Id is sum type
data Product a b = Product a b deriving (Eq,Show) -- type and data binary constructors, Product is product type
data Sum a b = First a | Second b deriving (Eq,Show) -- Sum is sum type with 2 data constructors
data RecordProduct a b =
  RecordProduct {
    pfirst  :: a,
    psecond :: b
  } deriving (Eq,Show) -- Record syntax
```

#### Different ways of constructing value
```haskell
trivalValue :: GuessWhat
trivalValue = Chickenbutt

idInt :: Id (a->a)
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
```

#### Different ways of deconstructing value
