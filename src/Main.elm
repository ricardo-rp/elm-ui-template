module Main exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Html exposing (Html)



---- MODEL ----


type alias Model =
    { openOption : Maybe DropdownOption
    }


init : ( Model, Cmd Msg )
init =
    ( { openOption = Nothing }, Cmd.none )



---- UPDATE ----


type DropdownOption
    = Option1
    | Option2


type Msg
    = OpenDropdown DropdownOption


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OpenDropdown option ->
            ( { model
                | openOption =
                    if Just option == model.openOption then
                        Nothing

                    else
                        Just option
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        blue =
            rgb255 50 100 200
    in
    layout []
        (column
            [ Background.color blue
            , Border.color (rgb255 0 0 0)
            , Border.width 2
            , padding 20
            , spacing 20
            ]
            [ row [ spacing 10 ]
                [ Input.button
                    []
                    { label = text "Option 1"
                    , onPress = Just (OpenDropdown Option1)
                    }
                , if model.openOption == Just Option1 then
                    text "I'm open!"

                  else
                    text ""
                ]
            , row [ spacing 10 ]
                [ Input.button []
                    { label = text "Option 2"
                    , onPress = Just (OpenDropdown Option2)
                    }
                , if model.openOption == Just Option2 then
                    text "I'm open!"

                  else
                    text ""
                ]
            ]
        )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
