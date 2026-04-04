import FS from "node:fs/promises"
import Path from "node:path"

import YAML from "js-yaml"

import { pipe, tee } from "@dashkite/joy/function"
import * as M from "@dashkite/masonry"
import * as T from "@dashkite/masonry-targets"
import * as H from "@dashkite/masonry-hooks"

import Type from "./type"

export default ( Genie ) ->

  options = Genie.get "type"
  
  Genie.define "type:build", "type:clean", M.start [
    T.glob options.targets
    H.read
    tee ( context ) ->
      specifier = YAML.load context.input
      context.build.preset ?= "css"
      context.output = Type.stylesheet specifier
    T.extension ".${ build.preset }"
    T.write "build/${ build.target }"
  ]

  Genie.on "build", "type:build"
  
  Genie.define "type", "type:build"

  Genie.define "type:clean", "clean"
