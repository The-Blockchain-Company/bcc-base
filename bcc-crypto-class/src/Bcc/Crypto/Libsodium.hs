module Bcc.Crypto.Libsodium (
  -- * Initialization
  sodiumInit,
  -- * MLocked memory management
  MLockedForeignPtr,
  withMLockedForeignPtr,
  allocMLockedForeignPtr,
  finalizeMLockedForeignPtr,
  traceMLockedForeignPtr,
  -- * MLocked bytes
  MLockedSizedBytes,
  mlsbZero,
  mlsbFromByteString,
  mlsbFromByteStringCheck,
  mlsbToByteString,
  mlsbFinalize,
  -- * Hashing
  SodiumHashAlgorithm (..),
  digestMLockedStorable,
  digestMLockedBS,
  expandHash,
) where

import Bcc.Crypto.Libsodium.Hash
import Bcc.Crypto.Libsodium.Init
import Bcc.Crypto.Libsodium.Memory
import Bcc.Crypto.Libsodium.MLockedBytes
