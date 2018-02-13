module Data.Todo.Task where

import Data.Todo.Boundary

data Task = Task
    { id :: TaskId
    , creationDate :: CreationDate
    , title :: TaskTitle
    , completion :: Completion
    , reminder :: Reminder
    , dueDate :: DueDate
    , description :: TaskDescription }

newtype TaskId = TaskId UUID

data TaskTitle = TaskTitle SingleLineNonBlankText

data CreationDate = CreationDate Date

data Completion
    = ToDo
    | Done Date

data Reminder
    = NoReminder
    | Reminder Date Time

data DueDate
    = NoDueDate
    | DueDate Date
    | RecurringDueDate Date Recurrence

data Recurrence
    = EachDay
    | EachWeekDay
    | EachWeek
    | EachMonth
    | EachYear

data TaskDescription = TaskDescription MultiLineMaybeBlankText

createTask :: TaskId -> CreationDate -> TaskTitle -> Task
createTask id creationDate title = Task
    { id
    , title
    , creationDate
    , completion: ToDo
    , reminder: NoReminder
    , dueDate: NoDueDate
    , description: TaskDescription "" }
