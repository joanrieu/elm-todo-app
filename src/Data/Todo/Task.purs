module Data.Todo.Task (Task) where

import Data.Todo.Ref (Ref)
import Data.Todo.Boundary (SingleLineText, MultiLineText, Time, Date)

data Task = Task {
    ref :: Ref Task,
    title :: Title,
    creationDate :: TimeAndDate,
    completion :: Completion,
    reminder :: Reminder,
    dueDate :: DueDate,
    description :: Description
}

data Title = Title SingleLineText

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

data Description = Description MultiLineText
