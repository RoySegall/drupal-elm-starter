module App.Model
    exposing
        ( emptyModel
        , Flags
        , Msg(..)
        , Model
        , Sidebar(..)
        )

import App.PageType exposing (Page(..))
import Board.Model
import Config.Model
import Date exposing (Date)
import Pages.Login.Model exposing (emptyModel, Model)
import Pusher.Model exposing (PusherEvent)
import RemoteData exposing (RemoteData(..), WebData)
import ItemManager.Model exposing (emptyModel, Model)
import Time exposing (Time)
import User.Model exposing (..)


type Msg
    = HandleOfflineEvent (Result String Bool)
    | HandlePusherEvent (Result String PusherEvent)
    | Logout
    | MsgBoardManager Board.Model.Msg
    | MsgItemManager ItemManager.Model.Msg
    | PageLogin Pages.Login.Model.Msg
    | SetActivePage Page
    | SetCurrentDate Date
    | Tick Time
    | ToggleSideBar


type alias Model =
    { accessToken : String
    , activePage : Page
    , config : RemoteData String Config.Model.Model
    , currentDate : Date
    , offline : Bool
    , pageLogin : Pages.Login.Model.Model
    , pageItem : ItemManager.Model.Model
    , sidebarOpen : Bool
    , user : WebData User
    , boards : Board.Model.Model
    }


type alias Flags =
    { accessToken : String
    , hostname : String
    }


type Sidebar
    = Top
    | Left


emptyModel : Model
emptyModel =
    { accessToken = ""
    , activePage = Login
    , config = NotAsked
    , currentDate = Date.fromTime 0
    , offline = False
    , pageLogin = Pages.Login.Model.emptyModel
    , pageItem = ItemManager.Model.emptyModel
    , sidebarOpen = False
    , user = NotAsked
    , boards = Board.Model.emptyModel
    }
