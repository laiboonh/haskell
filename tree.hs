{-# OPTIONS_GHC -Wall #-}

data Tree a = Node a (Tree a) (Tree a)
            | Empty
    deriving (Show)

simpleTree :: Tree String
simpleTree = Node "w" Empty Empty

data MyTree a = MyNode a (Maybe (MyTree a)) (Maybe (MyTree a))
    deriving (Show)

mySimpleTree :: MyTree String
mySimpleTree = MyNode "root" (Just (MyNode "1" Nothing Nothing)) Nothing
