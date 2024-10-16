module Main where

import Control.Monad.IO.Class (liftIO)
import DB (Account (..), LedgerEntry (..), migrateAll)
import Data.Time (getCurrentTime)
import Data.UUID.V4 qualified as V4
import Database.Persist (insert)
import Database.Persist.Sqlite (runMigration, runSqlite)
import Ledger (sumLedger)

main :: IO ()
ma = runSqlite ":memory:" $ do
  runMigration migrateAll

  t <- liftIO getCurrentTime

  -- acc1Id <- liftIO V4.nextRandom
  acc1 <- insert Account
  _ <- insert $ LedgerEntry 100 t acc1
  _ <- insert $ LedgerEntry 92 t acc1
  _ <- insert $ LedgerEntry (-24) t acc1

  acc <- dummyAccount1
  let ledger = dummyLedger t acc
  print ledger
  putStrLn ""
  putStrLn $ " total is: " <> show (sumLedger ledger)

-- dummyLedger :: UTCTime -> AccountId -> [LedgerEntry]
-- dummyLedger t acc = [
--   mkCredit (Money 10) t acc,
--   mkCredit (Money 92) t acc,
--   mkDebit (Money 101) t acc,
--   mkCredit (Money 11) t acc
--   ]
