module Main where

import Prelude

import App.Home as Home
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  HA.awaitBody >>= \x -> runUI Home.component unit x
