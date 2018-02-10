module Data.Todo.Boundary where

type Emoji = String
type SingleLineNonBlankText = String
type MultiLineMaybeBlankText = String
type Time = { hour :: Int, minute :: Int }
type Date = { day :: Int, month :: Int, year :: Int }
