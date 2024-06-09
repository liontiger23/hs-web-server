{-# LANGUAGE OverloadedStrings #-}

module Server (main) where

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)

app :: Application
app request respond = do
  respond $ case rawPathInfo request of
    "/" -> index
    "/test/" -> text
    _ -> notFound

text :: Response
text = responseLBS
    status200
    [("Content-Type", "text/plain")]
    "Hello, Web!"

index :: Response
index = responseFile
  status200
  [("Content-Type", "text/html")]
  "index.html"
  Nothing

notFound :: Response
notFound = responseFile
  status200
  [("Content-Type", "text/html")]
  "404.html"
  Nothing

main :: IO ()
main = do
  putStrLn "http://localhost:8080/"
  run 8080 app
