module Main exposing (..)

import Html.App
import Html exposing (Html, div, h2, text, img, button, select, option)
import Html.Attributes exposing (src, type', defaultValue, value)
import Html.Events exposing (onClick, onInput, on, targetValue)
import Task exposing (perform)
import Http exposing (get)
import Json.Decode as Json


main =
    Html.App.program { init = init, update = update, subscriptions = subscriptions, view = view }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODEL


type alias Model =
    { topic : String
    , gifUrl : String
    , loading : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( Model "cats" "waiting.gif" True, getRandomGif "cats" )



-- UPDATE


type Msg
    = MorePlease
    | FetchSucceed String
    | FetchFail Http.Error
    | ChangeTopic String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( { model | loading = True }, getRandomGif model.topic )

        FetchSucceed newUrl ->
            ( Model model.topic newUrl False, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )

        ChangeTopic topic ->
            ( Model topic model.gifUrl True, getRandomGif topic )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
    Json.at [ "data", "image_url" ] Json.string



-- VIEW


view : Model -> Html Msg
view model =
    let
        optionGenerator =
            \label -> option [] [ text label ]
    in
        div []
            [ h2 [] [ text model.topic ]
            , select [ on "change" (Json.map ChangeTopic targetValue) ]
                [ optionGenerator "cats"
                , optionGenerator "dogs"
                , optionGenerator "breaking bad"
                , optionGenerator "springsteen"
                ]
            , button [ onClick MorePlease ] [ text "More Please!" ]
            , div []
                (if model.loading then
                    [ text "Loading..." ]
                 else
                    [ img [ src model.gifUrl ] [] ]
                )
            ]
