module Main exposing (..)

import Html exposing (Html, button, div, text, h1)
import Html.App as App
import Html.Events exposing (onClick)


main =
    App.beginnerProgram { model = 0, view = view, update = update }


type alias Model =
    Int


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Counter" ]
        , button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "Reset" ]
        ]
