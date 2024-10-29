module Main where

import Control.Monad.IO.Class (liftIO)
import DB (Account (..), EntityField (LedgerEntryAccountId), LedgerEntry (..), migrateAll)
import Data.Time (getCurrentTime)
import Data.UUID.V4 qualified as V4
import Database.Persist (insert, selectList, (==.))
import Database.Persist.Sqlite (runMigration, runSqlite)

main :: IO ()
main = runSqlite ":memory:" $ do
  runMigration migrateAll

  t <- liftIO getCurrentTime

  -- acc1Id <- liftIO V4.nextRandom
  acc1 <- insert Account
  _ <- insert $ LedgerEntry 100 t acc1
  _ <- insert $ LedgerEntry 92 t acc1
  _ <- insert $ LedgerEntry (-24) t acc1

  ledger <- selectList [LedgerEntryAccountId ==. acc1] []

  liftIO $ do
    print ledger
    putStrLn ""
