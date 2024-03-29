module Todo.TaskList exposing (..)

import Todo.Boundary exposing (..)


type alias TaskList =
    { id : TaskListId
    , title : TaskListTitle
    , icon : TaskListIcon
    , sortOrder : SortOrder
    }


type alias TaskListId =
    UUID


type alias TaskListTitle =
    SingleLineNonBlankText


type TaskListIcon
    = TaskListIcon Emoji
    | NoTaskListIcon


type SortOrder
    = CustomOrder
    | SortOrder SortBy SortDirection


type SortBy
    = SortByTitle
    | SortByCreationDate
    | SortByCompletion
    | SortByDueDate


type SortDirection
    = SortAscending
    | SortDescending
