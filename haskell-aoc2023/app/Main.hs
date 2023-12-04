module Main (main) where

import Day1

main :: IO ()
main = do
  input <- readFile "../inputs/day1"
  putStrLn $ Day1.solve input
