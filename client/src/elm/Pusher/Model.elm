module Pusher.Model exposing (..)

import Board.Model exposing (Board, BoardMessage)
import Item.Model exposing (Item, ItemId)


type Cluster
    = ApSouthEast1
    | EuWest1
    | UsEast1


type alias PusherAppKey =
    { key : String
    , cluster : Cluster
    }


type alias PusherEvent =
    { itemId : ItemId
    , data : PusherEventData
    }


type PusherEventData
    = ItemUpdate Item
    | BoardMessageUpdate BoardMessage
    | BoardUpdate Board


{-| Return the event names that should be added via JS.
-}
eventNames : List String
eventNames =
    [ "item__update"
    , "create__board_messages"
    , "create__board"
    ]
