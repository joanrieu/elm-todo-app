module Data.Todo.Task exposing (..)

import Data.Todo.Boundary exposing (..)


type Task
    = Task
        { id : TaskId
        , creationDate : CreationDate
        , title : TaskTitle
        , completion : Completion
        , reminder : Reminder
        , dueDate : DueDate
        , description : TaskDescription
        }


type alias TaskId =
    UUID


type TaskTitle
    = TaskTitle SingleLineNonBlankText


type CreationDate
    = CreationDate Date


type Completion
    = ToDo
    | Done Date


type Reminder
    = NoReminder
    | Reminder Date Time


type DueDate
    = NoDueDate
    | DueDate Date
    | RecurringDueDate Date Recurrence


type Recurrence
    = EachDay
    | EachWeekDay
    | EachWeek
    | EachMonth
    | EachYear


type TaskDescription
    = TaskDescription MultiLineMaybeBlankText


createTask : TaskId -> CreationDate -> TaskTitle -> Task
createTask id creationDate title =
    Task
        { id = id
        , title = title
        , creationDate = creationDate
        , completion = ToDo
        , reminder = NoReminder
        , dueDate = NoDueDate
        , description = TaskDescription ""
        }
