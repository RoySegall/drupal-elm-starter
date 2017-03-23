module Board.View exposing (view)

import Board.Model exposing (Board, BoardMessage, BoardMessagesDict, BoardsDict, Model, Msg(..))
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Model -> Html Msg
view model =
    div
        [ class "ui grid" ]
        [ div
            [ class "row" ]
            [ viewBoards model.boards
            , viewBoard model.activeBoard model.messages
            ]
        ]


viewBoard : Maybe Board -> BoardMessagesDict -> Html Msg
viewBoard activeBoard messages =
    case activeBoard of
        Just board ->
            div
                [ class "eleven wide column" ]
                [ div
                    [ class "board-title" ]
                    [ h2 [] [ text board.label ]
                    ]
                , table
                    [ class "ui celled table" ]
                    (Dict.values messages
                        |> List.sortBy (\record -> Result.withDefault 0 (String.toInt record.id))
                        |> List.map viewBoardMessage
                    )
                , div
                    [ class "messages-form" ]
                    [ input
                        [ placeholder "add new message"
                        , onInput UpdateMessage
                        ]
                        []
                    , a
                        [ onClick SendMessage ]
                        [ i
                            [ class "plus icon button" ]
                            []
                        ]
                    ]
                ]

        Nothing ->
            div [ class "column" ] []


viewBoards : BoardsDict -> Html Msg
viewBoards boards =
    div
        [ class "five wide column" ]
        [ h2
            []
            [ text "Chatrooms" ]
        , table
            [ class "ui celled table" ]
            (Dict.values boards
                |> List.sortBy (\record -> Result.withDefault 0 (String.toInt record.id))
                |> List.map viewBoardInListing
            )
        , div
            [ class "board-form" ]
            [ input
                [ placeholder "add new board"
                , onInput UpdateBoard
                ]
                []
            , a
                [ onClick SendBoard ]
                [ i
                    [ class "plus icon button" ]
                    []
                ]
            ]
        ]


viewBoardInListing : Board -> Html Msg
viewBoardInListing board =
    tr
        []
        [ td
            []
            [ a
                [ class "item"
                , onClick <| FetchBoardMessages board.id
                ]
                [ text board.label ]
            ]
        ]


viewBoardMessage : BoardMessage -> Html Msg
viewBoardMessage message =
    tr
        []
        [ td
            []
            [ text message.text ]
        ]
