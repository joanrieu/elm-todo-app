module Data.Todo.TaskList where

import Data.Todo.Task
import Data.Todo.Boundary

data TaskList = TaskList
    { id :: TaskListId
    , title :: TaskListTitle
    , icon :: TaskListIcon
    , taskRefs :: Array TaskId
    , sortOrder :: SortOrder }

newtype TaskListId = TaskListId UUID

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
