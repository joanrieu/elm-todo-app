module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Data.Todo.Task exposing (..)
import Data.Todo.TaskList exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }


type alias Model =
    { taskLists : List TaskList
    , tasks : List Task
    }


init : Model
init =
    { taskLists =
        [ { id = "today"
          , title = "Today"
          , icon = NoTaskListIcon
          , taskRefs = []
          , sortOrder = CustomOrder
          }
        ]
    , tasks = []
    }


type Msg
    = CreateTask TaskTitle TaskListId
    | CheckTask TaskId
    | UncheckTask TaskId
    | ChangeTaskTitle TaskId TaskTitle
    | ChangeTaskReminder TaskId Reminder
    | ChangeTaskDueDate TaskId DueDate
    | ChangeTaskDescription TaskId TaskDescription
    | DeleteTask TaskId
    | CreateTaskList TaskListTitle
    | ChangeTaskListTitle TaskListId TaskListTitle
    | ChangeTaskListIcon TaskListId TaskListIcon
    | MoveTaskIntoList TaskId TaskListId
    | ReorderTaskInsideList TaskId Int
    | SortTaskList TaskId SortOrder
    | DeleteTaskList TaskListId


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreateTask title taskListRef ->
            { model
                | tasks =
                    [ createTask
                        "mytask"
                        { day = 1, month = 12, year = 2017 }
                        title
                    ]
            }

        _ ->
            model


view : Model -> Html Msg
view model =
    let
        viewTaskList : Model -> TaskList -> Html Msg
        viewTaskList model taskList =
            div []
                [ div []
                    [ text taskList.title ]
                , div []
                    (List.map viewInlineTask model.tasks)
                , div []
                    [ button [ (onClick (CreateTask "abc" "def")) ]
                        [ text "Add task" ]
                    ]
                ]

        viewInlineTask : Task -> Html Msg
        viewInlineTask task =
            div [] [ text task.title ]
    in
        div []
            (List.map (viewTaskList model) model.taskLists)
