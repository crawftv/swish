port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { answerInput : String
    , courseList :
        List String
        -- , exerciseList : Exercises
    }


type alias Lesson =
    { id : String }


type alias Exercises =
    { exerciseObjects : List ExercisePairs
    }


type alias ExercisePairs =
    { q : String
    , a : String
    }


type Msg
    = InputAnswer String
    | LessonListLoaded (List String)



-- | ExerciseListLoaded Exercises


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
    -- { answerInput = "", courseList = [], exerciseList = {[]} }
    { answerInput = "", courseList = [] }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputAnswer answerInput ->
            ( { model | answerInput = answerInput }, Cmd.none )

        LessonListLoaded loadCourse ->
            ( { model | courseList = loadCourse }, Cmd.none )



-- ExerciseListLoaded loadExerciseList ->
--     ( { model | exerciseList = loadExerciseList }, Cmd.none )


port loadLesson : (List String -> msg) -> Sub msg


port loadExercise : (Exercises -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadLesson LessonListLoaded
          -- , loadExercise ExerciseListLoaded
        ]


courseView : String -> Html Msg
courseView course =
    li []
        [ text course ]


courseListView : List String -> Html Msg
courseListView courses =
    courses
        |> List.map courseView
        |> ul []



-- exerciseView : Exercises -> Html Msg
-- exerciseView exercise =
--     tr []
--         [ td [] [ text (toString exercise.q) ]
--         , td [] [ text (toString exercise.a) ]
--         ]
--
-- exerciseListView : List Exercises -> Html Msg
-- exerciseListView exercises =
--     exercises
--         |> List.map exerciseView
--         |> tbody []
--


view : Model -> Html Msg
view model =
    div []
        [ courseListView model.courseList
        , text "elm Works"
        ]
