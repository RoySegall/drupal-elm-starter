module Board.Encoder
    exposing
        ( encodeBoard
        , encodeBoardDict
        , encodeBoardMessage
        )

import Board.Model exposing (Board, BoardsDict)
import Dict exposing (Dict)
import Json.Encode as Encode exposing (int, list, object, string)
import Utils.Json exposing (encodeDict)


encodeBoard : Board -> Encode.Value
encodeBoard board =
    object
        [ ( "id", int board.id )
        , ("label" string board.label)
        , ("description" string board.description)
        , ("dummy_field" string board.dummyField)
        ]


encodeBoardDict : BoardsDict -> Encode.Value
encodeBoardDict =
    encodeDict encodeBoard


encodeBoardMessage : BoardMessage -> Encode.Value
encodeBoardMessage boardMessage =
    object
        [ ( "id", int boardMessage.id )
        , ("text" string boardMessage.text)
        ]
