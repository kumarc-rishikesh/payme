module Main where

import Control.Monad.IO.Class (liftIO)
import DB (Account (..), LedgerEntry (..), migrateAll)
import Data.Time (getCurrentTime)
import Database.Esqueleto.Experimental (entityVal, from, insert, runMigration, select, table)
import Database.Persist.Sqlite (runSqlite)
import Ledger (sumLedger)

main :: IO ()
main = runSqlite ":memory:" $ do
  runMigration migrateAll

  t <- liftIO getCurrentTime

  -- acc1Id <- liftIO V4.nextRandom
  acc1 <- insert Account
  _ <- insert $ LedgerEntry 100 t acc1
  _ <- insert $ LedgerEntry 92 t acc1
  _ <- insert $ LedgerEntry (-24) t acc1

  -- ledger <- selectList [LedgerEntryAccountId ==. acc1] []
  ledger <-
    select $ do from $ table @LedgerEntry
  liftIO $ do
    print ledger
    putStrLn ""
    putStrLn $ "Total is : " <> show (sumLedger (entityVal <$> ledger))
