module Data.Todo.Boundary (Emoji, SingleLineText, MultiLineText, Time, Date) where

data Emoji = Emoji String
data SingleLineText = SingleLineText String
data MultiLineText = MultiLineText String
data Time = Time { hour :: Int, minute :: Int }
data Date = Date { day :: Int, month :: Int, year :: Int }
