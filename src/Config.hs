{-# LANGUAGE OverloadedStrings #-}

module Config where

import qualified Data.Configurator as Cfg
import qualified Data.Configurator.Types as Cfg
import Control.Applicative
import qualified Data.ByteString.Lazy.Char8 as B

data Config = Config {
    ignore :: Maybe [String],
    sourceFolders :: Maybe [String]
} deriving (Show)

config :: String -> IO Config
config file = do
  config <- Cfg.load [Cfg.Optional file]
  ignore <- Cfg.lookup config "ignore"
  sourceFolders <- Cfg.lookup config "sourceFolders"
  return $ Config ignore sourceFolders
