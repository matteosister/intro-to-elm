module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.App
import Html.Events exposing (onClick)
import Random exposing (generate, int, pair)
import Svg exposing (Svg, svg, circle, rect)
import Svg.Attributes exposing (..)


main =
    Html.App.program { init = init, update = update, subscriptions = subscriptions, view = view }


type alias Model =
    { dieFace1 : Int
    , dieFace2 : Int
    }


type Msg
    = Roll
    | NewFaces ( Int, Int )


init : ( Model, Cmd Msg )
init =
    ( Model 1 1, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            let
                generator =
                    Random.pair (Random.int 1 6) (Random.int 1 6)
            in
                ( model, Random.generate NewFaces generator )

        NewFaces ( newFace1, newFace2 ) ->
            ( Model newFace1 newFace2, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ drawDice model.dieFace1
        , drawDice model.dieFace2
        , button [ onClick Roll ] [ text "Roll" ]
        ]


drawDice : Int -> Html Msg
drawDice num =
    case num of
        1 ->
            draw1

        2 ->
            draw2

        3 ->
            draw3

        4 ->
            draw4

        5 ->
            draw5

        6 ->
            draw6

        _ ->
            div [] [ text "error" ]


drawCircle : ( Int, Int ) -> Svg Msg
drawCircle ( x, y ) =
    circle [ cx (toString x), cy (toString y), r "8" ] []


drawCircles : List ( Int, Int ) -> List (Svg Msg)
drawCircles coords =
    List.map drawCircle coords


drawDiceBorder : Svg Msg
drawDiceBorder =
    rect [ x "0", y "0", width "100", height "100", rx "15", ry "15", fill "lightgray" ] []


drawSingleDice : List ( Int, Int ) -> Html Msg
drawSingleDice coords =
    svg
        [ width "100", height "100", viewBox "0 0 100 100" ]
        (List.append [ drawDiceBorder ] (drawCircles coords))


draw1 : Html Msg
draw1 =
    drawSingleDice [ ( 50, 50 ) ]


draw2 : Html Msg
draw2 =
    drawSingleDice [ ( 80, 20 ), ( 20, 80 ) ]


draw3 : Html Msg
draw3 =
    drawSingleDice [ ( 50, 50 ), ( 20, 80 ), ( 80, 20 ) ]


draw4 : Html Msg
draw4 =
    drawSingleDice [ ( 80, 20 ), ( 20, 80 ), ( 80, 80 ), ( 20, 20 ) ]


draw5 : Html Msg
draw5 =
    drawSingleDice [ ( 80, 20 ), ( 20, 80 ), ( 80, 80 ), ( 20, 20 ), ( 50, 50 ) ]


draw6 : Html Msg
draw6 =
    drawSingleDice [ ( 80, 20 ), ( 80, 50 ), ( 80, 80 ), ( 20, 20 ), ( 20, 50 ), ( 20, 80 ) ]
