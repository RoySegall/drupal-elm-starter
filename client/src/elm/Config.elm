module Config exposing (configs)

import Config.Model as Config exposing (Model)
import Dict exposing (..)
import LocalConfig exposing (localConfigs)
import Pusher.Model exposing (Cluster(..), PusherAppKey)


devPantheon : Model
devPantheon =
    { backendUrl = "http://dev-ddd-nuntius.pantheonsite.io"
    , name = "devPantheon"
    , pusherKey = PusherAppKey "4d86cb3a71b2412a2ab5" UsEast1
    }


testPantheon : Model
testPantheon =
    { backendUrl = "http://test-ddd-nuntius.pantheonsite.io"
    , name = "testPantheon"
    , pusherKey = PusherAppKey "" UsEast1
    }


livePantheon : Model
livePantheon =
    { backendUrl = "http://live-ddd-nuntius.pantheonsite.io"
    , name = "livePantheon"
    , pusherKey = PusherAppKey "" UsEast1
    }


configs : Dict String Model
configs =
    Dict.fromList
        [ ( "http://dev-ddd-nuntius.pantheonsite.io", devPantheon )
        , ( "http://test-ddd-nuntius.pantheonsite.io", testPantheon )
        , ( "http://live-ddd-nuntius.pantheonsite.io", livePantheon )
        ]
        |> Dict.union localConfigs
