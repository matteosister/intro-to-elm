module Counter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { num : Int
    , maxValue : Int
    , minValue : Int
    , clicksCount : Int
    }


init : Int -> Model
init count =
    Model count count count 0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            let
                newValue =
                    model.num + 1

                maxValue =
                    Basics.max newValue model.maxValue

                minValue =
                    model.minValue
            in
                Model newValue maxValue minValue (model.clicksCount + 1)

        Decrement ->
            let
                newValue =
                    model.num - 1

                maxValue =
                    model.maxValue

                minValue =
                    Basics.min newValue model.minValue
            in
                Model newValue maxValue minValue (model.clicksCount + 1)



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle ] [ text (toString model.num) ]
        , button [ onClick Increment ] [ text "+" ]
        , div [] [ text ("max value: " ++ (model.maxValue |> toString)) ]
        , div [] [ text ("min value: " ++ (model.minValue |> toString)) ]
        , div [] [ text ("clicks: " ++ (model.clicksCount |> toString)) ]
        ]


countStyle : Attribute msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
