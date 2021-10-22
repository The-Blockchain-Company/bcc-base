{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Bcc.Binary.Raw
  ( Raw(..)
  )
where

import Bcc.Prelude

import Bcc.Binary.FromCBOR (FromCBOR)
import Bcc.Binary.ToCBOR (ToCBOR)


-- | A wrapper over 'ByteString' for signalling that a bytestring should be
--   processed as a sequence of bytes, not as a separate entity. It's used in
--   crypto and binary code.
newtype Raw = Raw ByteString
  deriving (Eq, Ord, Show, NFData, FromCBOR, ToCBOR)
