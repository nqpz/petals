import "../../lib/github.com/athas/matte/colour"
import "../../src/types"
import "../../src/operations"
import "../../src/shapes"

let mask = with_input (\(inp: input) ->
                         scale 0.5 (circle (f32.abs (f32.sin inp.time))
                                           ^^^ square (f32.abs (f32.cos inp.time))))

let color_on = const argb.white
let color_off = const argb.black
