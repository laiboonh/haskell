# Nothing
```haskell
type Name = String
type Age = Integer

data Person = Person Name Age deriving Show

mkPerson :: Name -> Age -> Maybe Person
mkPerson name age
  | name /= "" && age >=0 = Just $ Person name age
  | otherwise = Nothing
```
# Either
```haskell
data PersonInvalid = NameEmpty | AgeTooLow deriving (Eq,Show)

mkPerson' :: Name -> Age -> Either PersonInvalid Person
mkPerson' name age
  | name /= "" && age >=0 = Right $ Person name age
  | name == "" = Left NameEmpty
  | otherwise = Left AgeTooLow
```
#### improvement
```haskell

```
