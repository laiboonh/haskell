{-# OPTIONS_GHC -Wall #-}

module SimpleJSON
  (
    JValue(..),
    getString,
    getDouble,
    getBool,
    getObject,
    getArray,
    isNull    
  ) where


data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject [(String,JValue)]
            | JArray [JValue] deriving (Eq, Ord, Show)

getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _ = Nothing

getDouble :: JValue -> Maybe Double
getDouble (JNumber d) = Just d
getDouble _ = Nothing

getBool :: JValue -> Maybe Bool
getBool (JBool b) = Just b
getBool _ = Nothing

getObject :: JValue -> Maybe [(String, JValue)]
getObject (JObject o) = Just o
getObject _ = Nothing

getArray :: JValue -> Maybe [JValue]
getArray (JArray v) = Just v
getArray _ = Nothing

isNull :: JValue -> Bool
isNull v = v == JNull
