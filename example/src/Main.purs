module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

import Data.Generic (class Generic, gEq)
import Data.Either (Either (..))
import Data.Argonaut (class EncodeJson, class DecodeJson, encodeJson, decodeJson)
import Data.Argonaut.Encode.Generic (gEncodeJson)
import Data.Argonaut.Decode.Generic (gDecodeJson)
import Data.MsgPack.Node as MsgPack


data Foo = Foo | Bar

derive instance genericFoo :: Generic Foo

instance eqFoo :: Eq Foo where
  eq = gEq

instance encodeJsonFoo :: EncodeJson Foo where
  encodeJson = gEncodeJson

instance decodeJsonFoo :: DecodeJson Foo where
  decodeJson = gDecodeJson


main :: forall e. Eff (console :: CONSOLE | e) Unit
main = case MsgPack.decode $ MsgPack.encode $ encodeJson Foo of
  Left e -> log $ show e
  Right x -> case decodeJson x of
    Left e -> log e
    Right x -> case x of
      Foo -> log "success!"
      _   -> log "failure!"
