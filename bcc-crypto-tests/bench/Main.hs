module Main (main) where

import Criterion.Main
import Bcc.Crypto.Libsodium.Init

import qualified Bench.Crypto.VRF (benchmarks)
import qualified Bench.Crypto.KES (benchmarks)

main :: IO ()
main = do
  sodiumInit
  defaultMain benchmarks

benchmarks :: [Benchmark]
benchmarks =
  [ Bench.Crypto.VRF.benchmarks
  , Bench.Crypto.KES.benchmarks
  ]
