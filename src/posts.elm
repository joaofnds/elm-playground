module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Model
    = Failure
    | Loading
    | Success Post


type alias Post =
    { id : Int
    , title : String
    , body : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading, getPosts )



-- UPDATE


type Msg
    = GotPosts (Result Http.Error Post)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotPosts result ->
            case result of
                Ok post ->
                    ( Success post, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "failed to load"

        Loading ->
            text "loading..."

        Success post ->
            div []
                [ h2 [] [ text "posts" ]
                , viewPost post
                ]


viewPostList : List Post -> List (Html Msg)
viewPostList posts =
    List.map viewPost posts


viewPost : Post -> Html Msg
viewPost post =
    div []
        [ p []
            [ em [] [ text "id: " ]
            , text (String.fromInt post.id)
            ]
        , p []
            [ em [] [ text "title: " ]
            , text post.title
            ]
        , p []
            [ em [] [ text "body: " ]
            , text post.body
            ]
        ]



-- HTTP


getPosts : Cmd Msg
getPosts =
    Http.get
        { url = "https://jsonplaceholder.typicode.com/posts/1"
        , expect = Http.expectJson GotPosts postDecoder
        }


postDecoder : Decoder Post
postDecoder =
    map3 Post
        (at [ "id" ] int)
        (at [ "title" ] string)
        (at [ "body" ] string)
