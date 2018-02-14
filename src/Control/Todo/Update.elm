module Control.Todo.Update exposing (..)

import Data.Todo.Boundary exposing (..)
import Data.Todo.TaskList exposing (..)
import Data.Todo.Task exposing (..)
import Control.Todo.Msg exposing (..)


type alias Model =
    { taskLists : List TaskList
    , tasks : List Task
    }


init : Model
init =
    { taskLists =
        [ TaskList
            { id = "today"
            , title = TaskListTitle "Today"
            , icon = NoTaskListIcon
            , taskRefs = []
            , sortOrder = CustomOrder
            }
        ]
    , tasks = []
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreateTask name taskListRef ->
            { model
                | tasks =
                    [ createTask
                        "mytask"
                        (CreationDate { day = 1, month = 12, year = 2017 })
                        (TaskTitle "Do something!")
                    ]
            }

        _ ->
            model
