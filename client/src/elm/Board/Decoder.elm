module Board.Decoder
    exposing
        ( decodeBoard
        , decodeBoardMessage
        , decodeBoardMessagesDict
        , decodeBoardsDict
        , decodeBoardFromResponse
        , decodeBoardsFromResponse
        , decodeBoardMessagesFromResponse
        )

import Json.Decode exposing (Decoder, at, dict, string)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Board.Model exposing (..)
import Utils.Json exposing (decodeListAsDict, decodeId)


decodeBoard : Decoder Board
decodeBoard =
    decode Board
        |> required "id" decodeId
        |> required "label" string
        |> required "description" string


decodeBoardsDict : Decoder BoardsDict
decodeBoardsDict =
    decodeListAsDict decodeBoard


decodeBoardMessage : Decoder BoardMessage
decodeBoardMessage =
    decode BoardMessage
        |> required "id" decodeId
        |> required "text" string


decodeBoardMessagesDict : Decoder BoardMessagesDict
decodeBoardMessagesDict =
    decodeListAsDict decodeBoardMessage


decodeBoardFromResponse : Decoder Board
decodeBoardFromResponse =
    at [ "data", "0" ] decodeBoard


decodeBoardsFromResponse : Decoder BoardsDict
decodeBoardsFromResponse =
    at [ "data" ] decodeBoardsDict


decodeBoardMessagesFromResponse : Decoder BoardMessagesDict
decodeBoardMessagesFromResponse =
    at [ "data" ] decodeBoardMessagesDict
