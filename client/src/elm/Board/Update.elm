module Board.Update exposing (update, fetchBoardsFromBackend)

import Board.Decoder exposing (..)
import Board.Model exposing (..)
import Config.Model exposing (BackendUrl)
import Dict
import HttpBuilder exposing (..)
import Json.Encode exposing (object)
import Utils.WebData exposing (sendWithHandler)


update : BackendUrl -> String -> Msg -> Model -> ( Model, Cmd Msg )
update backendUrl accessToken msg model =
    case msg of
        FetchBoardMessages boardId ->
            let
                board =
                    Dict.get boardId model.boards
            in
                ( { model | activeBoard = board }
                , fetchBoardMessagesFromBackend backendUrl accessToken boardId
                )

        HandleFetchedBoards (Ok boardsDict) ->
            ( { model | boards = boardsDict }
            , Cmd.none
            )

        HandleFetchedBoards (Err err) ->
            -- Here we should do some error handling.
            ( model
            , Cmd.none
            )

        HandleFetchedBoard (Ok board) ->
            ( { model | boards = Dict.insert board.id board model.boards }
            , Cmd.none
            )

        HandleFetchedBoard (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                -- Here we should do some error handling.
                ( model
                , Cmd.none
                )

        HandleFetchedBoardMessages (Ok boardMessagesDict) ->
            ( { model | messages = boardMessagesDict }
            , Cmd.none
            )

        HandleFetchedBoardMessages (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
                -- Here we should do some error handling.
                ( model
                , Cmd.none
                )

        UpdateMessage newMessage ->
            ( { model | newMessage = Just newMessage }
            , Cmd.none
            )

        SendMessage ->
            let
                command =
                    case model.newMessage of
                        Just message ->
                            case model.activeBoard of
                                Just board ->
                                    sendBoardMessageToBackend backendUrl accessToken board.id message

                                Nothing ->
                                    Cmd.none

                        Nothing ->
                            Cmd.none
            in
                ( model
                , command
                )

        UpdateBoard newBoard ->
            ( { model | newBoard = Just newBoard }
            , Cmd.none
            )

        SendBoard ->
            let
                command =
                    case model.newBoard of
                        Just board ->
                            sendBoardToBackend backendUrl accessToken board

                        Nothing ->
                            Cmd.none
            in
                ( model
                , command
                )


fetchBoardsFromBackend : BackendUrl -> String -> Cmd Msg
fetchBoardsFromBackend backendUrl accessToken =
    HttpBuilder.get (backendUrl ++ "/api/boards")
        |> withQueryParams [ ( "access_token", accessToken ) ]
        |> sendWithHandler decodeBoardsFromResponse HandleFetchedBoards


fetchBoardMessagesFromBackend : BackendUrl -> String -> BoardId -> Cmd Msg
fetchBoardMessagesFromBackend backendUrl accessToken boardId =
    HttpBuilder.get (backendUrl ++ "/api/board_messages")
        |> withQueryParams [ ( "access_token", accessToken ), ( "filter[board]", boardId ) ]
        |> sendWithHandler decodeBoardMessagesFromResponse HandleFetchedBoardMessages


sendBoardToBackend : BackendUrl -> String -> String -> Cmd Msg
sendBoardToBackend backendUrl accessToken newBoard =
    let
        json =
            object
                [ ( "label", Json.Encode.string newBoard )
                , ( "description", Json.Encode.string "" )
                ]
    in
        HttpBuilder.post (backendUrl ++ "/api/boards")
            |> withQueryParams [ ( "access_token", accessToken ) ]
            |> withJsonBody json
            |> sendWithHandler decodeBoardFromResponse HandleFetchedBoard


sendBoardMessageToBackend : BackendUrl -> String -> BoardId -> String -> Cmd Msg
sendBoardMessageToBackend backendUrl accessToken boardId newMessage =
    let
        json =
            object
                [ ( "text", Json.Encode.string newMessage )
                , ( "board", Json.Encode.string boardId )
                ]
    in
        HttpBuilder.post (backendUrl ++ "/api/board_messages")
            |> withQueryParams [ ( "access_token", accessToken ) ]
            |> withJsonBody json
            |> sendWithHandler decodeBoardMessagesFromResponse HandleFetchedBoardMessages
