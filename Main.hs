module Main where

import System.Environment (getArgs)
import Distribution.Simple.Configure (getConfigStateFile)
-- import Distribution.PackageDescription.Parse
-- import Distribution.Verbosity (silent)
-- import Data.Generics.Text

x :: Int
x = _

main = do
  (path:_) <- getArgs
  print =<< getConfigStateFile path
--  pkgDesc <- readPackageDescription silent path

