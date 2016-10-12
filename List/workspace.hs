xs :: [(Int,Int)]
xs = [(x,y) | x<-[1,2,3], y<-[]]

seekritFunc :: Fractional a => String -> a
seekritFunc x =  (sum(map (fromIntegral . length) (words x))) / ((fromIntegral . length) (words x))
