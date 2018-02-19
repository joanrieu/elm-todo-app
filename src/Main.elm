module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Style exposing (..)
import Todo.Task exposing (..)
import Todo.TaskList exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }


type alias TodoModel =
    { taskLists : List TaskList
    , tasks : List Task
    }


type alias ViewModel =
    { openTaskListId : TaskListId
    }


type alias Model =
    { todo : TodoModel
    , view : ViewModel
    }


init : Model
init =
    { todo =
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
    , view =
        { openTaskListId = "today"
        }
    }


type TodoMsg
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


type ViewMsg
    = OpenTaskList TaskListId


type Msg
    = TodoMsg TodoMsg
    | ViewMsg ViewMsg


updateTodo : TodoMsg -> TodoModel -> TodoModel
updateTodo msg model =
    case msg of
        CreateTask title taskListRef ->
            let
                task =
                    createTask
                        "mytask"
                        { day = 1, month = 12, year = 2017 }
                        title

                tasks =
                    task :: model.tasks
            in
                { model | tasks = tasks }

        _ ->
            model


update : Msg -> Model -> Model
update msg model =
    case msg of
        TodoMsg msg ->
            { model | todo = updateTodo msg model.todo }

        _ ->
            model


viewTaskList : Model -> TaskList -> Html Msg
viewTaskList model taskList =
    div []
        [ div
            [ style
                [ backgroundColor "blue"
                , color "white"
                ]
            ]
            [ text taskList.title ]
        , div []
            (List.map viewInlineTask model.todo.tasks)
        , div []
            [ button [ (onClick (TodoMsg (CreateTask "abc" "def"))) ]
                [ text "Add task" ]
            ]
        ]


viewInlineTask : Task -> Html Msg
viewInlineTask task =
    div [] [ text task.title ]


view : Model -> Html Msg
view model =
    let
        isOpenTaskList taskList =
            taskList.id == model.view.openTaskListId

        openTaskList =
            model.todo.taskLists
                |> List.filter isOpenTaskList
                |> List.head

        taskListView =
            openTaskList
                |> Maybe.map (viewTaskList model)
                |> Maybe.withDefault (text "No open task list")
    in
        div []
            [ taskListView ]
