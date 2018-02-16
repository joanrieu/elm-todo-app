module Todo.Task exposing (..)

import Todo.Boundary exposing (..)


type alias Task =
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


type alias TaskTitle =
    SingleLineNonBlankText


type alias CreationDate =
    Date


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


type alias TaskDescription =
    MultiLineMaybeBlankText


createTask : TaskId -> CreationDate -> TaskTitle -> Task
createTask id creationDate title =
    { id = id
    , title = title
    , creationDate = creationDate
    , completion = ToDo
    , reminder = NoReminder
    , dueDate = NoDueDate
    , description = ""
    }
