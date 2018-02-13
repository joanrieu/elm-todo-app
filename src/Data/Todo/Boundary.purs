module Data.Todo.Boundary where

newtype UUID = UUID String
type Emoji = String
type SingleLineNonBlankText = String
type MultiLineMaybeBlankText = String
type Time = { hour :: Int, minute :: Int }
type Date = { day :: Int, month :: Int, year :: Int }
