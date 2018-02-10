module Data.Todo.TaskList (TaskList) where

import Data.Todo.Ref (Ref)
import Data.Todo.Task (Task)
import Data.Todo.Boundary (Emoji, SingleLineText)

data TaskList = TaskList {
    name :: Title,
    tasks :: Array (Ref Task),
    sortOrder :: SortOrder
}

data Title
    = Title SingleLineText
    | EmojiTitle Emoji SingleLineText

data SortOrder
    = CustomOrder
    | SortOrder SortBy SortDirection

data SortBy
    = SortByTitle
    | SortByCreationDate
    | SortByCompletion
    | SortByDueDate

data SortDirection
    = SortAscending
    | SortDescending
