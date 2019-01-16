module Crypto.Subtle.Key.Import
  ( importKey
  , ImportFormat, raw, pkcs8, spki, jwk
  , ImportAlgorithm, rsa, ec, hmac, aes
  ) where

import Crypto.Subtle.Key.Types (CryptoKey, CryptoKeyUsage)
import Crypto.Subtle.Hash (HashingFunction)
import Crypto.Subtle.RSA (RSAAlgorithm)
import Crypto.Subtle.EC (ECAlgorithm, ECCurve)
import Crypto.Subtle.AES (AESAlgorithm)

import Prelude ((<<<), (<$))
import Data.Function.Uncurried (Fn5, runFn5)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Data.Either (Either (..))
import Effect.Promise (Promise, runPromise)
import Effect.Aff (Aff, makeAff, nonCanceler)
import Unsafe.Coerce (unsafeCoerce)



foreign import importKeyImpl :: Fn5 ImportFormat ArrayBuffer ImportAlgorithm Boolean (Array CryptoKeyUsage) (Promise CryptoKey)


importKey :: ImportFormat
          -> ArrayBuffer -- ^ Key data
          -> ImportAlgorithm
          -> Boolean -- ^ Extractable
          -> Array CryptoKeyUsage
          -> Aff CryptoKey
importKey f x a e u = makeAff \resolve ->
  nonCanceler <$ runPromise (resolve <<< Right) (resolve <<< Left) (runFn5 importKeyImpl f x a e u)


newtype ImportFormat = ImportFormat String

raw :: ImportFormat
raw = ImportFormat "raw"
pkcs8 :: ImportFormat
pkcs8 = ImportFormat "pkcs8"
spki :: ImportFormat
spki = ImportFormat "spki"
jwk :: ImportFormat
jwk = ImportFormat "jwk"




foreign import data ImportAlgorithm :: Type


rsa :: RSAAlgorithm -> HashingFunction -> ImportAlgorithm
rsa r h = unsafeCoerce {name: r, hash: h}

ec :: ECAlgorithm -> ECCurve -> ImportAlgorithm
ec e c = unsafeCoerce {name: e, namedCurve: c}

hmac :: HashingFunction -> ImportAlgorithm
hmac h = unsafeCoerce {name: "HMAC", hash: h}

aes :: AESAlgorithm -> ImportAlgorithm
aes a = unsafeCoerce {name: a}