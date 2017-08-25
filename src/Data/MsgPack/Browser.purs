module Data.MsgPack.Browser
  ( encode, decode
  ) where

import Prelude
import Data.Either (Either (..))
import Data.Argonaut (Json)
import Data.Function.Uncurried (Fn3, runFn3)
import Control.Monad.Eff.Exception (Error)
import Data.ArrayBuffer.Types (ArrayBuffer)


foreign import encode :: Json -> ArrayBuffer

foreign import decodeImpl :: Fn3 (Error -> Either Error Json)
                                 (Json -> Either Error Json)
                                 ArrayBuffer
                                 (Either Error Json)

decode :: ArrayBuffer -> Either Error Json
decode = runFn3 decodeImpl Left Right
