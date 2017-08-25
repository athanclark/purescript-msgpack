module Data.MsgPack.Node
  ( encode, decode
  ) where

import Prelude
import Data.Either (Either (..))
import Data.Argonaut (Json)
import Data.Function.Uncurried (Fn3, runFn3)
import Control.Monad.Eff.Exception (Error)
import Node.Buffer (Buffer)


foreign import encode :: Json -> Buffer

foreign import decodeImpl :: Fn3 (Error -> Either Error Json)
                                 (Json -> Either Error Json)
                                 Buffer
                                 (Either Error Json)

decode :: Buffer -> Either Error Json
decode = runFn3 decodeImpl Left Right
