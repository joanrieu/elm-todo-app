module Data.Todo.TaskList where

import Data.Todo.Ref (Ref)
import Data.Todo.Task (Task)
import Data.Todo.Boundary (Emoji, SingleLineNonBlankText)

data TaskList = TaskList
    { title :: TaskListTitle
    , icon :: TaskListIcon
    , taskRefs :: Array (Ref Task)
    , sortOrder :: SortOrder }

data TaskListTitle = TaskListTitle SingleLineNonBlankText

data TaskListIcon
    = TaskListIcon Emoji
    | NoTaskListIcon

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
