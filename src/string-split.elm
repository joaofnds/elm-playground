module Main exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { input : String }


init : Model
init =
    Model ""



-- UPDATE


type Msg
    = Input String


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Input input ->
            { input = input }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", value model.input, placeholder "foo", onInput Input ] []
        , charList model.input
        ]


charList : String -> Html msg
charList input =
    let
        chars =
            String.split "" input
    in
    toHtmlList chars


toHtmlList : List String -> Html msg
toHtmlList strings =
    ul [] (List.map toLi strings)


toLi : String -> Html msg
toLi content =
    li [] [ text content ]
