module Main where

import System.Environment (getArgs)
import Distribution.Simple.Configure (getConfigStateFile, ConfigStateFileError(..))
import Distribution.Simple.Utils (cabalVersion)
import System.Directory (doesFileExist)
import System.Exit (exitWith, ExitCode(..))
import System.IO (stderr, hPutStrLn)
import Control.Exception
import Control.Monad (when)

main = do
  (path:_) <- getArgs
  exists <- doesFileExist path
  when (not exists) $ do
    hPutStrLn stderr $ show path ++ " does not exist. Please open an issue at https://github.com/imeckler/cabalparse."
    exitWith (ExitFailure 1)

  succ <- try (print =<< getConfigStateFile path)
  case (succ :: Either ConfigStateFileError ()) of
    Right ()                            -> return ()
    Left (ConfigStateFileBadVersion {}) -> do
      let err = "The installed version of cabal is older than "
              ++ show cabalVersion
              ++ " which is the version used by cabalparse."
              ++ "If this version has become out of date, "
              ++ "please open an issue at https://github.com/imeckler/cabalparse."
      hPutStrLn stderr $ err
      exitWith (ExitFailure 1)

