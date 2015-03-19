module Main where

import System.Environment (getArgs)
import Distribution.Simple.Configure (getConfigStateFile)

main = do
  (path:_) <- getArgs
  print =<< getConfigStateFile path

