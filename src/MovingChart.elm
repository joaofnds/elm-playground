module Main exposing (Model, Msg(..), Point, chart, data1, data2, init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import LineChart
import LineChart.Colors as Colors
import LineChart.Dots as Dots
import Task
import Time


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0
    , Cmd.none
    )



-- UPDATE


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( remainderBy 360 (model + 1), Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 10 Tick



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div
            [ class "container" ]
            [ chart model ]
        ]


chart i =
    LineChart.view
        .x
        .y
        [ LineChart.line Colors.blue Dots.none "sin(x)" (data1 i)
        , LineChart.line Colors.red Dots.none "cos(x)" (data2 i)
        ]


type alias Point =
    { x : Float, y : Float }


data1 : Int -> List Point
data1 i =
    List.range 0 60
        |> List.map toFloat
        |> List.map (\n -> Point n (sin (degrees (n * pi * 2 + toFloat i))))


data2 : Int -> List Point
data2 i =
    List.range 0 60
        |> List.map toFloat
        |> List.map (\n -> Point n (cos (degrees (n * pi * 2 + toFloat i))))
