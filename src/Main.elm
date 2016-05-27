port module Main exposing (..)

import String

import Html exposing (Html, div, text, input, label, button)
import Html.App as App
import Html.Attributes exposing (class)
import Html.Events exposing (onInput, onClick)

port updateMap : Model -> Cmd msg

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { zoom : Int
  , lat : Int 
  , lng : Int
  }

type Msg
  = NoOp
  | UpdateMap
  | UpdateZoom String
  | UpdateLat String
  | UpdateLng String


init : (Model, Cmd Msg)
init = 
  (Model 0 0 0, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg) 
update msg model =
  case Debug.log "msg" msg of
    UpdateMap ->
      (model, updateMap model)

    UpdateZoom newZoom ->
      ({ model | zoom = Result.withDefault 0 (String.toInt newZoom) }, Cmd.none)

    UpdateLat newlat ->
      ({ model | lat = Result.withDefault 0 (String.toInt newlat) }, Cmd.none)

    UpdateLng newlng ->
      ({ model | lat = Result.withDefault 0 (String.toInt newlng) }, Cmd.none)

    _ ->
      (model, Cmd.none)


view : Model -> Html Msg
view model =
  div
    [ class "map__config" ]
    [ label [] [ text "Zoom: " ]
    , input [ onInput UpdateZoom ] []
    , div 
        []
        [ label [] [ text "Lat: "] 
        , input [ onInput UpdateLat ] []
        ]
    , div 
        []
        [ label [] [ text "Lng: "] 
        , input [ onInput UpdateLng ] []
        ]
    , button [ onClick UpdateMap ] [ text "Update" ]
    , displayPayload model
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HELPERS

displayPayload : Model -> Html Msg
displayPayload model =
  div
    []
    [ text (toString model)]

