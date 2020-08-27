module App.Home where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Halogen.HTML.Events as HE
import Halogen.Transition as Transition

import App.Element as UI
import Data.Const (Const)
import Data.Maybe (Maybe(..))
import Data.Symbol (SProxy(..))
import Effect.Aff (Aff)


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
      { handleAction = handleAction }
    }

-----
-- Render

renderInner :: Transition.HTML Action Aff
renderInner =
  HH.div
  [ HE.onClick $ Just <<< const (Transition.raise OnClick) ]
  [ HH.text "hello world!" ]

render :: State -> HTML
render state =
  HH.section_
    [ UI.h1_ [ HH.text "This is pretty cool hey!" ]
    , UI.content_
        [ UI.p_
            """
            My name is Jeff.
            """
        , UI.a
            [ HP.href "www.google.com.au" ]
            [ HH.text "google!" ]
      ]
    , HH.button
          [ HE.onClick $ Just <<< const OnClick ]
          [ HH.text "toggle" ]
    , HH.slot _transition unit Transition.component 
    { enterClass: "simple-enter"
    , enterActiveClass: "simple-enter-active"
    , leaveClass: "simple-leave"
    , leaveActiveClass: "simple-leave-active"
    , shown: state.shown
    , render: renderInner
    } $ Just <<< HandleTransition
  ]


-----
-- Actions

handleAction :: Action -> DSL Unit
handleAction = case _ of
  OnClick -> do
    H.modify_ $ \s -> s { shown = not s.shown }

  HandleTransition msg -> do
    handleAction msg
