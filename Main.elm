port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http


type alias Model =
    { answerInput : String
    , courseList : List String
    }


type alias Lesson =
    { id : String }


type Msg
    = InputAnswer String
    | LessonListLoaded (List String)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


initModel : Model
initModel =
    { answerInput = "", courseList = [] }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputAnswer answerInput ->
            ( { model | answerInput = answerInput }, Cmd.none )

        LessonListLoaded loadCourse ->
            ( { model | courseList = loadCourse }, Cmd.none )


port loadLesson : (List String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    loadLesson LessonListLoaded


courseView : String -> Html Msg
courseView course =
    li []
        [ text course ]


courseListView : List String -> Html Msg
courseListView courses =
    courses
        |> List.map courseView
        |> ul []


view : Model -> Html Msg
view model =
    div []
        [ courseListView model.courseList
        , text "elm Works"
        ]
