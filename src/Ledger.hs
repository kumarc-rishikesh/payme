{-# LANGUAGE DerivingStrategies #-}

module Ledger(
    LedgerEntry,
    mkCredit,
    mkDebit,
    sumLedger
) where

import Data.Time (UTCTime)
import Data.UUID (UUID)
import Money(Money (..))

data LedgerEntry = LedgerEntry {
    transactioniType :: TransactionType,
    amount :: Money,
    datetime :: UTCTime,
    accountId :: UUID
} deriving stock (Show, Eq)

mkCredit :: Money -> UTCTime -> UUID -> LedgerEntry
mkCredit = LedgerEntry Credit

mkDebit :: Money -> UTCTime -> UUID -> LedgerEntry
mkDebit amount = LedgerEntry Debit (-amount)

ledgerAmount :: LedgerEntry -> Money
ledgerAmount (LedgerEntry Credit amount _ _) = amount
ledgerAmount (LedgerEntry Debit amount _ _) = amount

sumLedger :: (Traversable t) => t LedgerEntry -> Money
sumLedger = foldl (\acc x-> acc + ledgerAmount x) (Money 0)

data TransactionType = Credit | Debit
    deriving stock (Show, Eq)
