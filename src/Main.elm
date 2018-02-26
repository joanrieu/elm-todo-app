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


type alias Model =
    { todo : TodoModel
    , view :
        { openTaskListId : TaskListId
        , openTaskId : Maybe TaskId
        }
    }


init : Model
init =
    { todo =
        { taskLists =
            [ { id = "today"
              , title = "Today"
              , icon = NoTaskListIcon
              , sortOrder = CustomOrder
              }
            , { id = "someday"
              , title = "Someday"
              , icon = NoTaskListIcon
              , sortOrder = CustomOrder
              }
            ]
        , tasks = []
        }
    , view =
        { openTaskListId = "today"
        , openTaskId = Nothing
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


type Msg
    = TodoMsg TodoMsg
    | OpenTaskList TaskListId
    | OpenTask TaskId


updateTodo : TodoMsg -> TodoModel -> TodoModel
updateTodo msg model =
    case msg of
        CreateTask title taskListId ->
            let
                task =
                    createTask
                        "mytask"
                        taskListId
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

        OpenTaskList taskListId ->
            let
                view =
                    model.view
            in
                { model | view = { view | openTaskListId = taskListId } }

        OpenTask taskId ->
            let
                view =
                    model.view
            in
                { model | view = { view | openTaskId = Just taskId } }


viewAllTaskLists : Model -> Html Msg
viewAllTaskLists model =
    let
        viewTaskListTitle taskList =
            div [ onClick (OpenTaskList taskList.id) ]
                [ text taskList.title ]
    in
        model.todo.taskLists
            |> List.map viewTaskListTitle
            |> div []


viewTaskList : Model -> TaskList -> Html Msg
viewTaskList model taskList =
    let
        tasks =
            model.todo.tasks
                |> List.filter (\t -> t.taskListId == taskList.id)
    in
        div []
            [ div
                [ style
                    [ backgroundColor "blue"
                    , color "white"
                    ]
                ]
                [ text taskList.title ]
            , div []
                (List.map viewInlineTask tasks)
            , div []
                [ button [ (onClick (TodoMsg (CreateTask "abc" model.view.openTaskListId))) ]
                    [ text "Add task" ]
                ]
            ]


viewInlineTask : Task -> Html Msg
viewInlineTask task =
    div [ onClick (OpenTask task.id) ]
        [ input [ type_ "checkbox", checked (isCompleted task) ] []
        , text task.title
        , div []
            [ viewInlineTaskDueDate task
            , viewInlineTaskReminder task
            ]
        ]


viewInlineTaskDueDate : Task -> Html Msg
viewInlineTaskDueDate task =
    case task.dueDate of
        NoDueDate ->
            div []
                []

        DueDate date ->
            div []
                [ text "📅 "
                , text (toString date.day)
                , text "/"
                , text (toString date.month)
                , text "/"
                , text (toString date.year)
                ]

        RecurringDueDate date recurrence ->
            div []
                [ text "📅 "
                , text (toString date.day)
                , text "/"
                , text (toString date.month)
                , text "/"
                , text (toString date.year)
                , text " (recurring)"
                ]


viewInlineTaskReminder : Task -> Html Msg
viewInlineTaskReminder task =
    case task.reminder of
        NoReminder ->
            div []
                []

        Reminder date time ->
            div []
                [ text "🔔 "
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


viewTask : Task -> Html Msg
viewTask task =
    task |> toString |> text


view : Model -> Html Msg
view model =
    let
        allTaskListsView =
            viewAllTaskLists model

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

        isOpenTask task =
            case model.view.openTaskId of
                Just taskId ->
                    task.id == taskId

                Nothing ->
                    False

        openTask =
            model.todo.tasks
                |> List.filter isOpenTask
                |> List.head

        openTaskView =
            openTask
                |> Maybe.map viewTask
                |> Maybe.withDefault (text "No open task")
    in
        div []
            [ allTaskListsView
            , taskListView
            , openTaskView
            ]
