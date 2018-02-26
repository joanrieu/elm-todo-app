module Todo.Task exposing (..)

import Todo.TaskList exposing (TaskListId)
import Todo.Boundary exposing (..)


type alias Task =
    { id : TaskId
    , taskListId : TaskListId
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


createTask : TaskId -> TaskListId -> CreationDate -> TaskTitle -> Task
createTask id taskListId creationDate title =
    { id = id
    , taskListId = taskListId
    , title = title
    , creationDate = creationDate
    , completion = ToDo
    , reminder = NoReminder
    , dueDate = NoDueDate
    , description = ""
    }


isCompleted : Task -> Bool
isCompleted task =
    case task.completion of
        ToDo ->
            False

        Done _ ->
            True
