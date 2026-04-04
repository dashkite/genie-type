import defaults from "./defaults"

generate = ( n, start, rate ) ->
  for i in [ 0...n ]
    start * Math.pow ( 1 + rate ), i

Generators =

  prefix: ( namespace, level ) ->
    if namespace? then "#{ level }-#{ namespace }" else level

  classes: ( namespace, level ) ->
    if namespace? then ".#{ level }.#{ namespace }" else ".#{ level }"

Type =

  defaults: defaults

  stylesheet: ( specifier ) ->
    if Array.isArray specifier
      specifier
        .map Type.stylesheet
        .join "\n"
    else
      { 
        namespace
        levels
        container
        harmonic
        spacing
        start
        scale
        responsiveness 
      } = { Type.defaults..., specifier... }

      range = ( container.minimum / container.maximum ) + container.units

      base = start
      notes = generate levels.length, base, harmonic

      css = []
      root = [ ":root {" ]

      for lower, i in notes
        level = levels[ i ]
        upper = base * Math.pow ( 1 + harmonic ), i + 1
        delta = ( upper - lower ) * scale.factor
        start_val = ( lower * scale.factor ) + scale.units
        variance = responsiveness * delta

        prefix = Generators.prefix namespace, level
      
        line_height_var = "--#{ prefix }-line-height"
        font_size_var = "--#{ prefix }-font-size"

        root.push "  #{ line_height_var }: round(nearest, calc(#{ start_val } + (#{ variance } * (1cqi - #{ range }))), #{ scale.factor }rem);"
        root.push "  #{ font_size_var }: calc(var(#{ line_height_var }) * #{ spacing });"

        classes = Generators.classes namespace, level
        css.push "#{ classes } {"
        css.push "  line-height: var(#{ line_height_var });"
        css.push "  font-size: var(#{ font_size_var });"
        css.push "}"

      root.push "}"
      [ root.join("\n"), css.join("\n") ].join("\n")

export default Type