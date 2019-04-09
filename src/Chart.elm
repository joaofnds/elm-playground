module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import LineChart
import LineChart.Colors as Colors
import LineChart.Dots as Dots


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { input : Int }


init : Model
init =
    Model 0



-- UPDATE


type Msg
    = Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            case String.toInt input of
                Just num ->
                    { input = num }

                Nothing ->
                    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div
            [ class "container" ]
            [ chart model.input ]
        , input
            [ type_ "range"
            , value <| String.fromInt model.input
            , Html.Attributes.min "0"
            , Html.Attributes.max "500"
            , Html.Attributes.style "width" "500px"
            , onInput Input
            ]
            []
        , text (String.fromInt model.input)
        ]


chart numOfPoints =
    LineChart.view
        .x
        .y
        -- [ LineChart.line Colors.blue Dots.none "2^n" (data1 numOfPoints)
        -- , LineChart.line Colors.red Dots.none "n*n" (data2 numOfPoints)
        -- , LineChart.line Colors.green Dots.none "n" (data3 numOfPoints)
        [ LineChart.line Colors.blue Dots.none "sin(n)" (data4 numOfPoints)
        , LineChart.line Colors.red Dots.none "cos(n)" (data5 numOfPoints)
        ]


type alias Point =
    { x : Float, y : Float }


data1 : Int -> List Point
data1 numOfPoints =
    List.range 0 numOfPoints
        |> List.map toFloat
        |> List.map (\n -> Point n (2 ^ n))


data2 : Int -> List Point
data2 numOfPoints =
    List.range 0 numOfPoints
        |> List.map toFloat
        |> List.map (\n -> Point n (n * n))


data3 : Int -> List Point
data3 numOfPoints =
    List.range 0 numOfPoints
        |> List.map toFloat
        |> List.map (\n -> Point n n)


data4 : Int -> List Point
data4 numOfPoints =
    List.range 0 numOfPoints
        |> List.map toFloat
        |> List.map (\n -> Point n (sin (degrees n * pi * 2)))


data5 : Int -> List Point
data5 numOfPoints =
    List.range 0 numOfPoints
        |> List.map toFloat
        |> List.map (\n -> Point n (cos (degrees n * pi * 2)))
