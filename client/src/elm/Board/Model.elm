module Board.Model
    exposing
        ( Board
        , BoardId
        , BoardMessage
        , BoardMessagesDict
        , BoardMessageId
        , BoardsDict
        , Model
        , Msg(..)
        , emptyModel
        )

import Dict exposing (Dict)
import Http


type alias Model =
    { boards : BoardsDict
    , activeBoard : Maybe Board
    , messages : BoardMessagesDict
    , newMessage : String
    , newBoard : String
    }


type alias BoardId =
    String


type alias Board =
    { id : BoardId
    , label : String
    , description : String
    }


type alias BoardsDict =
    Dict BoardId Board


type alias BoardMessageId =
    String


type alias BoardMessage =
    { id : BoardMessageId
    , text : String
    }


type alias BoardMessagesDict =
    Dict BoardMessageId BoardMessage


type Msg
    = FetchBoardMessages BoardId
    | HandleFetchedBoard (Result Http.Error Board)
    | HandleFetchedBoards (Result Http.Error BoardsDict)
    | HandleFetchedBoardMessages (Result Http.Error BoardMessagesDict)
    | UpdateMessage String
    | SendMessage
    | UpdateBoard String
    | SendBoard


emptyModel : Model
emptyModel =
    { boards = Dict.empty
    , activeBoard = Nothing
    , messages = Dict.empty
    , newMessage = ""
    , newBoard = ""
    }
