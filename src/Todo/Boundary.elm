module Todo.Boundary exposing (..)


type alias UUID =
    String


type alias Emoji =
    String


type alias SingleLineNonBlankText =
    String


type alias MultiLineMaybeBlankText =
    String


type alias Time =
    { hour : Int, minute : Int }


type alias Date =
    { day : Int, month : Int, year : Int }
