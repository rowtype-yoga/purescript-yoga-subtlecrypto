{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "subtlecrypto"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "arraybuffer-types"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "foreign"
  , "functions"
  , "maybe"
  , "prelude"
  , "transformers"
  , "tuples"
  , "unsafe-coerce"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, license = "BSD-3-Clause"
, repository = "https://github.com/rowtype-yoga/purescript-yoga-subtlecrypto.git"
}
