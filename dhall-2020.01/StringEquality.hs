:set -XTemplateHaskell

import Control.Lens
import qualified Data.Text as Text
import qualified Dhall
import qualified Dhall.Context
import qualified Dhall.Core as Dhall
import qualified Dhall.TH

let textPredicateType = $(Dhall.TH.staticDhallExpression "Text -> Text -> Bool")

let updateContext = Dhall.Context.insert "Text/equal" textPredicateType . Dhall.Context.insert "Text/isPrefixOf" textPredicateType

let normalizer = \case
        -- Very primitive implementation, doesn't work when Chunks contain
        -- free variables.
        Dhall.App (Dhall.App (Dhall.Var "Text/equal") (Dhall.TextLit (Dhall.Chunks [] x))) (Dhall.TextLit (Dhall.Chunks [] y)) ->
            Just (Dhall.BoolLit (x == y))
        Dhall.App (Dhall.App (Dhall.Var "Text/isPrefixOf") (Dhall.TextLit (Dhall.Chunks [] x))) (Dhall.TextLit (Dhall.Chunks [] y)) ->
            Just (Dhall.BoolLit (x `Text.isPrefixOf` y))
        _ ->
            Nothing

let settings =
        Dhall.defaultInputSettings
        & Dhall.normalizer .~ Just (Dhall.ReifiedNormalizer (pure . normalizer))
        & Dhall.startingContext %~ updateContext

b :: Bool <- Dhall.inputWithSettings settings Dhall.auto "Text/isPrefixOf \"--hello=\" \"--hello=world\""

b :: Bool <- Dhall.inputWithSettings settings Dhall.auto "Text/isPrefixOf \"--bye-bye-cruel=\" \"--hello=world\""
