module Main where

import System.Environment
import Control.Applicative
import Runner
import Config
import System.Directory
import System.FilePath

main :: IO ()
main = do
    (_ : _ : dst : args) <- getArgs
    customConfiguration <- case args of
                            (configFile : _) -> Just <$> config configFile
                            _ -> return Nothing
    let sources = case customConfiguration of
                    Just (Config _ (Just sourceFolders')) -> sourceFolders'
                    _ -> ["src"]
    files <- mapM getAbsDirectoryContents sources
    let testDriverFileContents = driver (concat files) customConfiguration
    writeFile dst testDriverFileContents

getAbsDirectoryContents :: FilePath -> IO [FilePath]
getAbsDirectoryContents dir = getDirectoryContents dir >>= mapM (canonicalizePath . (dir </>))
