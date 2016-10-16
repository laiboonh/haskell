{-# OPTIONS_GHC -Wall #-}

data BinaryTree a =
  Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq,Ord,Show)

{-insert-}

insert :: Ord a => a -> BinaryTree a -> BinaryTree a
insert x Leaf = Node Leaf x Leaf
insert x (Node left y right)
    | x < y = Node (insert x left) y right
    | x > y = Node left y (insert x right)
    | otherwise = Node left y right

{-map-}

mapTree :: (a->b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left x right) =
  Node (mapTree f left) (f x) (mapTree f right)

mapTree' :: (Ord a, Ord b) => (a->b) -> BinaryTree a -> BinaryTree b
mapTree' f bt = foldTree (\x acc -> insert (f x) acc) Leaf bt

{-converting to list-}

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left x right) = x : (preorder left) ++ (preorder right)

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left x right) = (inorder left) ++ x: (inorder right)

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node left x right) = (postorder left) ++ (postorder right) ++ [x]

{-fold-}
foldTree :: (a->b->b) -> b -> BinaryTree a -> b
foldTree _ acc Leaf = acc
foldTree f acc (Node left x right) = f x (foldTree f (foldTree f acc right) left)


{----TESTS----}
testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

mapExpected :: BinaryTree Integer
mapExpected = Node (Node Leaf 2 Leaf) 3 (Node Leaf 4 Leaf)

testMapTree :: IO ()
testMapTree =
  if mapTree (+1) testTree == mapExpected
  then print "yup okay!"
  else error "test failed!"

testPreorder :: IO ()
testPreorder =
  if preorder testTree == [2,1,3]
    then print "Preorder fine!"
    else error "Preorder failed"

testInorder :: IO ()
testInorder =
  if inorder testTree == [1,2,3]
    then print "Inorder fine!"
    else error "Inorder failed"

testPostorder :: IO ()
testPostorder =
  if postorder testTree == [1,3,2]
    then print "Postorder fine!"
    else error "Postorder failed"
