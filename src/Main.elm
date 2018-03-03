module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Todo.Task exposing (..)
import Todo.TaskList exposing (..)
import Todo.Command exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }


type alias Model =
    { todo : TodoModel
    , view :
        { openTaskListId : TaskListId
        , openTaskId : Maybe TaskId
        , newTaskTitle : String
        }
    }


init : Model
init =
    { todo =
        Todo.Command.init
    , view =
        { openTaskListId = "today"
        , openTaskId = Nothing
        , newTaskTitle = ""
        }
    }


type Msg
    = TodoMsg TodoMsg
    | OpenTaskList TaskListId
    | OpenTask TaskId
    | UpdateNewTaskTitle String
    | CreateTask


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

        UpdateNewTaskTitle title ->
            let
                view =
                    model.view
            in
                { model | view = { view | newTaskTitle = title } }

        CreateTask ->
            let
                view =
                    model.view
            in
                { model
                    | todo =
                        updateTodo
                            (Todo.Command.CreateTask
                                model.view.newTaskTitle
                                model.view.openTaskListId
                            )
                            model.todo
                    , view = { view | newTaskTitle = "" }
                }


viewAllTaskLists : Model -> Html Msg
viewAllTaskLists model =
    let
        viewTaskListTitle taskList =
            div
                [ style [ ( "margin", "1rem" ) ]
                , onClick (OpenTaskList taskList.id)
                ]
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
                    [ ( "background-color", "blue" )
                    , ( "color", "white" )
                    , ( "font-size", "3em" )
                    , ( "padding", "2rem" )
                    ]
                ]
                [ text taskList.title ]
            , div []
                (List.map viewInlineTask tasks)
            , div
                [ style [ ( "margin", "1rem" ) ] ]
                [ input
                    [ onInput UpdateNewTaskTitle
                    , value model.view.newTaskTitle
                    ]
                    []
                , button
                    [ style [ ( "padding", ".2rem .5rem" ) ]
                    , (onClick CreateTask)
                    ]
                    [ text "Add task" ]
                ]
            ]


viewInlineTask : Task -> Html Msg
viewInlineTask task =
    div
        [ onClick (OpenTask task.id)
        , style [ ( "margin", "1rem" ) ]
        ]
        [ input
            [ type_ "checkbox"
            , checked (isCompleted task)
            , onClick
                (if isCompleted task then
                    TodoMsg (UncheckTask task.id)
                 else
                    TodoMsg (CheckTask task.id)
                )
            ]
            []
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
                |> List.singleton
                |> div [ style [ ( "padding", "1rem" ) ] ]
    in
        div
            [ style
                [ ( "width", "100vw" )
                , ( "height", "100vh" )
                , ( "display", "grid" )
                , ( "grid-template-columns", "20em auto 20em" )
                ]
            ]
            [ allTaskListsView
            , taskListView
            , openTaskView
            ]
