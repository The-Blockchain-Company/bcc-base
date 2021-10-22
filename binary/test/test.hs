import Bcc.Prelude
import Test.Bcc.Prelude

import qualified Test.Bcc.Binary.RoundTrip
import qualified Test.Bcc.Binary.SizeBounds
import qualified Test.Bcc.Binary.Serialization
import qualified Test.Bcc.Binary.Drop
import qualified Test.Bcc.Binary.Failure

-- | Main testing action
main :: IO ()
main = do
  runTests
    [ Test.Bcc.Binary.RoundTrip.tests
    , Test.Bcc.Binary.SizeBounds.tests
    , Test.Bcc.Binary.Serialization.tests
    , Test.Bcc.Binary.Drop.tests
    , Test.Bcc.Binary.Failure.tests
    ]
