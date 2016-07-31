module Main exposing (..)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Html.App as App
import String


main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { content : String }


model : Model
model =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]
