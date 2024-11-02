{-# LANGUAGE DerivingStrategies #-}

module Ledger (
  sumLedger,
) where

import DB (LedgerEntry (..))
import Data.Int (Int64)

sumLedger :: (Traversable t) => t LedgerEntry -> Int64
sumLedger = foldl (\acc x -> acc + x.ledgerEntryAmount) 0
