module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Regex exposing (regex, contains)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , submitted : Bool
    }


model : Model
model =
    Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | submitted = False, name = name }

        Password password ->
            { model | submitted = False, password = password }

        PasswordAgain password ->
            { model | submitted = False, passwordAgain = password }

        Age age ->
            { model | submitted = False, age = age }

        Submit ->
            { model | submitted = True }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type' "text", placeholder "Name", onInput Name ] []
        , input [ type' "password", placeholder "Password", onInput Password ] []
        , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , input [ type' "text", placeholder "Age", onInput Age ] []
        , button [ onClick Submit ] [ text "submit" ]
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    if model.submitted then
        div []
            [ (equalPasswordValidation model) |> outputMessage
            , (passwordLengthValidation model) |> outputMessage
            , (validFormat model) |> outputMessage
            , (checkAge model) |> outputMessage
            ]
    else
        div [] []


outputMessage : ( String, String ) -> Html msg
outputMessage ( color, message ) =
    div [ style [ ( "color", color ) ] ] [ text message ]


equalPasswordValidation : Model -> ( String, String )
equalPasswordValidation model =
    if model.password == model.passwordAgain then
        ( "green", "OK" )
    else
        ( "red", "Passwords do not match!" )


passwordLengthValidation : Model -> ( String, String )
passwordLengthValidation model =
    if String.length model.password >= 8 then
        ( "green", "OK" )
    else
        ( "red", "Passwords is too short, 8 chars min!" )


validFormat : Model -> ( String, String )
validFormat model =
    if isValidPassword model.password then
        ( "green", "OK" )
    else
        ( "red", "Passwords not valid, upper, lower and number required" )


isValidPassword : String -> Bool
isValidPassword password =
    contains (regex "[A-Z]+") password
        && contains (regex "[a-z]+") password
        && contains (regex "[0-9]+") password


checkAge : Model -> ( String, String )
checkAge model =
    case String.toInt model.age of
        Ok a ->
            ( "green", "OK" )

        Err err ->
            ( "red", "Age is not a number" )
