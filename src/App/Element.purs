module App.Element where

import Prelude

import DOM.HTML.Indexed (HTMLa)
import Halogen.HTML (p)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

type Plain i p = Array (HH.HTML i p) -> HH.HTML i p

class_ :: forall r t. String -> HH.IProp ( "class" :: String | r ) t
class_ = HP.class_ <<< HH.ClassName

----------
-- Typography

h1_ :: forall i p. Plain i p
h1_ = HH.h1 [ class_ "" ]

h2_ :: forall i p. Plain i p
h2_ = HH.h2 [ class_ "" ]

h3_ :: forall i p. Plain i p
h3_ = HH.h3 [ class_ "" ]

p_ :: forall i p. String -> HH.HTML i p
p_ str = HH.p_ [ HH.text str ]

a :: forall i p. Array (HH.IProp HTMLa p) -> Plain i p
a props = HH.a ([ class_ "" ] <> props)

----------
-- Layout

section_ :: forall i p. Plain i p
section_ content =
  HH.section [ class_ "container" ] content

content_ :: forall i p. Plain i p
content_ = HH.div [ class_ "" ]

row_ :: forall i p. Plain i p
row_ content = HH.div [ class_ "row" ] content
