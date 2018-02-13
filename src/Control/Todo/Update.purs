module Control.Todo.Update where

import Data.Todo.Boundary
import Data.Todo.TaskList
import Data.Todo.Task

import Control.Todo.Msg

data Model = Model
    { taskLists :: Array TaskList
    , tasks :: Array Task }

init :: Model
init = Model
    { taskLists:
        [ TaskList
            { title: TaskListTitle "Today"
            , icon: NoTaskListIcon
            , taskRefs: []
            , sortOrder: CustomOrder } ]
    , tasks: [] }

update :: Msg -> Model -> (Model, Cmd)
update (CreateTask name taskListRef) model
    = model { tasks: [ createTask
        (TaskId (UUID "mytask"))
        (CreationDate { day: 1, month: 12, year: 2017 })
        (TaskTitle "Do something!") ] }
