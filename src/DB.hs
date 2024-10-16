{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE UndecidableInstances       #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module DB where 

import Data.Int(Int64)
import Data.Time(UTCTime)
import Database.Persist.TH( mkMigrate, mkPersist, persistLowerCase, share, sqlSettings )

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
  LedgerEntry
    amount Int64
    datetime UTCTime
    accountId AccountId
    deriving Eq Show
  Account
    deriving Eq Show
|]
