port module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { answerInput : String
    , courseList : List String
    , lessonList : List String
    , exerciseList : List Exercise
    }


type alias Exercise =
    { q : String
    , a : String
    }


type Msg
    = InputAnswer String
    | CourseListLoaded (List String)
    | LessonListLoaded (List String)
    | ExerciseListLoaded (List Exercise)



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
    { answerInput = "", courseList = [], lessonList = [], exerciseList = [] }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputAnswer answerInput ->
            ( { model | answerInput = answerInput }, Cmd.none )

        CourseListLoaded loadCourse ->
            ( { model | courseList = loadCourse }, Cmd.none )

        LessonListLoaded loadLessonList ->
            ( { model | lessonList = loadLessonList }, Cmd.none )

        ExerciseListLoaded loadExerciseList ->
            ( { model | exerciseList = loadExerciseList }, Cmd.none )


port loadLesson : (List String -> msg) -> Sub msg


port loadCourse : (List String -> msg) -> Sub msg


port loadExerciseList : (List Exercise -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loadCourse CourseListLoaded
        , loadLesson LessonListLoaded
        , loadExerciseList ExerciseListLoaded
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


lessonView : String -> Html Msg
lessonView course =
    li []
        [ text course ]


lessonListView : List String -> Html Msg
lessonListView courses =
    courses
        |> List.map courseView
        |> ul []


exerciseView : Exercise -> Html Msg
exerciseView exercise =
    tr []
        [ td [] [ text (toString exercise.q) ]
        , td [] [ input [] [] ]
        ]


exerciseListView : List Exercise -> Html Msg
exerciseListView exercises =
    exercises
        |> List.map exerciseView
        |> tbody []


view : Model -> Html Msg
view model =
    div []
        [ text "Courses"
        , courseListView model.courseList
        , text "lessons"
        , lessonListView model.lessonList
        , text "exercises"
        , exerciseListView model.exerciseList
        , text "elm Works"
        ]
