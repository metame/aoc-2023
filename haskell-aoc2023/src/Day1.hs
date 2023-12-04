module Day1
where

import Text.Parsec as Parsec

import Data.Char (isDigit)


import Text.Parsec.String

letterParser :: Parser String
letterParser = Parsec.many letter

letterParser' :: Parser String
letterParser' = do
  l <- letter
  notFollowedBy digitParser
  return [l]

reverseLetterParser :: Parser String
reverseLetterParser = do
  l <- letter
  notFollowedBy reverseDigitParser
  return [l]

numberParser :: Parser Char
numberParser = oneOf "123456789"

numberParser' :: Parser String
numberParser' = do
  n <- numberParser
  return [n]

digitParser :: Parser String
digitParser =
  numberParser'
  <|> try (string "one")
  <|> try (string "two")
  <|> try (string "three")
  <|> try (string "four")
  <|> try (string "five")
  <|> try (string "six")
  <|> try (string "seven")
  <|> try (string "eight")
  <|> try (string "nine")

reverseDigitParser :: Parser String
reverseDigitParser =
  numberParser'
  <|> try (string "eno")
  <|> try (string "owt")
  <|> try (string "eerht")
  <|> try (string "ruof")
  <|> try (string "evif")
  <|> try (string "xis")
  <|> try (string "neves")
  <|> try (string "thgie")
  <|> try (string "enin")

prefixedDigit :: Parser String
prefixedDigit = do
  skipMany $ try letterParser'
  *> letter
  *> digitParser

firstDigit' :: Parser String
firstDigit' =
  digitParser
  <|> prefixedDigit

prefixedReverseDigit :: Parser String
prefixedReverseDigit = do
  skipMany $ try reverseLetterParser
  *> letter
  *> reverseDigitParser

lastDigit :: Parser String
lastDigit =
  reverseDigitParser
  <|> prefixedReverseDigit

firstDigit :: Parser Char
firstDigit = letterParser *> numberParser

parse :: Parser a -> String -> Either ParseError a
parse rule = Parsec.parse rule "(source)"

sumLine :: String -> Int
sumLine s = do
  let f = Day1.parse firstDigit s
  let l = Day1.parse firstDigit $ reverse s
  case (f, l) of
    (Right first, Right lst) -> read [first, lst]
    _ -> 0

toChar :: String -> Char
toChar "one" = '1'
toChar "two" = '2'
toChar "three" = '3'
toChar "four" = '4'
toChar "five" = '5'
toChar "six" = '6'
toChar "seven" = '7'
toChar "eight" = '8'
toChar "nine" = '9'
toChar s = if isDigit (head s) then head s else '0'

sumLine' :: String -> Int
sumLine' s = do
  let f = Day1.parse firstDigit' s
  let l = Day1.parse lastDigit $ reverse s
  case (f, l) of
    (Right first, Right lst) -> read [toChar first, toChar $ reverse lst]
    _ -> 0


part1 :: String -> String
part1 x = show $ sum $ map sumLine $ lines x

part2 :: String -> String
part2 x = show $ sum $ map sumLine' $ lines x

solve :: String -> String
solve = part2
