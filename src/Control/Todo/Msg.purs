module Control.Todo.Msg where

import Data.Todo.Ref (Ref)
import Data.Todo.Task (DueDate, Reminder, Task, TaskDescription, TaskTitle)
import Data.Todo.TaskList (SortOrder, TaskList, TaskListIcon, TaskListTitle)

data Msg
    = CreateTask TaskTitle (Ref TaskList)
    | CheckTask (Ref Task)
    | UncheckTask (Ref Task)
    | ChangeTaskTitle (Ref Task) TaskTitle
    | ChangeTaskReminder (Ref Task) Reminder
    | ChangeTaskDueDate (Ref Task) DueDate
    | ChangeTaskDescription (Ref Task) TaskDescription
    | DeleteTask (Ref Task)
    | CreateTaskList TaskListTitle
    | ChangeTaskListTitle (Ref TaskList) TaskListTitle
    | ChangeTaskListIcon (Ref TaskList) TaskListIcon
    | MoveTaskIntoList (Ref Task) (Ref TaskList)
    | ReorderTaskInsideList (Ref Task) Int
    | SortTaskList (Ref Task) SortOrder
    | DeleteTaskList (Ref TaskList)
