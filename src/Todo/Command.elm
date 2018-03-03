module Todo.Command exposing (..)

import Todo.Task exposing (..)
import Todo.TaskList exposing (..)
import Todo.Boundary exposing (..)


type alias TodoModel =
    { taskLists : List TaskList
    , tasks : List Task
    , date : Date
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


init : TodoModel
init =
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
    , date =
        { day = 1, month = 12, year = 2017 }
    }


updateTodo : TodoMsg -> TodoModel -> TodoModel
updateTodo msg model =
    case msg of
        CreateTask title taskListId ->
            let
                task =
                    createTask
                        "mytask"
                        taskListId
                        model.date
                        title
            in
                { model | tasks = task :: model.tasks }

        CheckTask taskId ->
            let
                updateTask task =
                    if task.id == taskId then
                        { task | completion = Done model.date }
                    else
                        task
            in
                { model | tasks = model.tasks |> List.map updateTask }

        UncheckTask taskId ->
            let
                updateTask task =
                    if task.id == taskId then
                        { task | completion = ToDo }
                    else
                        task
            in
                { model | tasks = model.tasks |> List.map updateTask }

        _ ->
            model
