module Data.Todo.Task where

import Data.Todo.Ref (Ref)
import Data.Todo.Boundary (Date, MultiLineMaybeBlankText, SingleLineNonBlankText, Time)

data Task = Task
    { ref :: Ref Task
    , title :: TaskTitle
    , creationDate :: TimeAndDate
    , completion :: Completion
    , reminder :: Reminder
    , dueDate :: DueDate
    , description :: TaskDescription }

data TaskTitle = TaskTitle SingleLineNonBlankText

data CreationDate = CreationDate TimeAndDate

data Completion
    = ToDo
    | Done TimeAndDate

data Reminder
    = NoReminder
    | Reminder TimeAndDate 

data TimeAndDate = TimeAndDate Time Date

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
