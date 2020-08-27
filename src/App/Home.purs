module App.Home where

import Prelude

import App.Element as UI
import Data.Const (Const)
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Aff (Aff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.Transition as Transition


type Plain i p = Array (HH.HTML i p) -> HH.HTML i p
type State = { shown :: Boolean }
data Action
  = OnClick
  | HandleTransition (Transition.Message Action)

type Slots = (transition :: Transition.Slot Action Unit)
type HTML = H.ComponentHTML Action Slots Aff
type DSL = H.HalogenM State Action Slots Void Aff

_transition = SProxy :: SProxy "transition"

initialState :: State
initialState = { shown: true }

-- Component

component :: H.Component HH.HTML (Const Void) Unit Void Aff
component = 
  H.mkComponent
    { initialState: const initialState
    , render
    , eval: H.mkEval H.defaultEval
    }

-----
-- Render

renderAnimation :: State -> String -> String -> HTML
renderAnimation state t fade = HH.slot _transition unit Transition.component 
    { enterClass: "simple-enter"
    , enterActiveClass: fade
    , leaveClass: "simple-leave"
    , leaveActiveClass: "simple-leave-active"
    , shown: state.shown
    , render: HH.text t
    } $ Just <<< HandleTransition



render :: State -> HTML
render state =
  HH.section_
    [ UI.row_ [ HH.h1_ [ renderAnimation initialState "Jarrod Li" "simple-enter-active-2"] ]
    , UI.row_ [ UI.h2_ [ renderAnimation initialState "Hello 👋" "simple-enter-active-4" ] ]
    , UI.content_
      [ UI.row_ [ UI.h3_ [ renderAnimation initialState "I'm a software engineer intern at an Australian bank." 
                 "simple-enter-active-8" ] ]
      , UI.row_ [ UI.h3_ [ renderAnimation initialState "I also study Computer Science and Law and UNSW Australia."
                 "simple-enter-active-8" ] ]
      , UI.row_ [ UI.h3_ [ renderAnimation initialState "This SPA was built with the Halogen framework and powered by purescript." 
                 "simple-enter-active-8" ] ]
      , UI.row_ 
        [ UI.a
            [ HP.href "https://www.linkedin.com/in/jarrodli/"  ]
            [ HH.text "linkedin" ]
        , UI.a
            [ HP.href "https://github.com/jarrodli" ]
            [ HH.text "github" ]
        , UI.a
            [ HP.href "https://github.com/jarrodli/jarrodsite "]
            [ HH.text "website source" ] 
        ]
      ]
    ]
