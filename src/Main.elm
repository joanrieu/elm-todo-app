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


type alias Model =
    { todo :
        { taskLists : List TaskList
        , tasks : List Task
        }
    , view :
        { openTaskListId : TaskListId
        }
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


asTasksIn : { b | tasks : a } -> a -> { b | tasks : a }
asTasksIn rec tasks =
    { rec | tasks = tasks }


asTodoIn : { b | todo : a } -> a -> { b | todo : a }
asTodoIn rec todo =
    { rec | todo = todo }


updateTodo : TodoMsg -> Model -> Model
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
                    task :: model.todo.tasks
            in
                tasks
                    |> asTasksIn model.todo
                    |> asTodoIn model

        _ ->
            model


update : Msg -> Model -> Model
update msg model =
    case msg of
        TodoMsg msg ->
            updateTodo msg model

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
    div []
        [ input [ type_ "checkbox", checked (isCompleted task) ] []
        , text task.title
        , div []
            [ viewInlineTaskDueDate task
            , viewInlineTaskReminder task
            ]
        ]


viewInlineTaskDueDate : Task -> Html Msg
viewInlineTaskDueDate task =
    div []
        (case task.dueDate of
            NoDueDate ->
                []

            DueDate date ->
                [ text "Due "
                , text (toString date.day)
                , text "/"
                , text (toString date.month)
                , text "/"
                , text (toString date.year)
                ]

            RecurringDueDate date recurrence ->
                [ text "Due "
                , text (toString date.day)
                , text "/"
                , text (toString date.month)
                , text "/"
                , text (toString date.year)
                , text " (recurring)"
                ]
        )


viewInlineTaskReminder : Task -> Html Msg
viewInlineTaskReminder task =
    div []
        (case task.reminder of
            NoReminder ->
                []

            Reminder date time ->
                [ text "Reminder on "
                , text (toString date.day)
                , text "/"
                , text (toString date.month)
                , text "/"
                , text (toString date.year)
                , text " at "
                , text (toString time.hour)
                , text ":"
                , text (toString time.minute)
                ]
        )


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
