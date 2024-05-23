import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/random"

let mask = with_input (\(inp: input) ->
                         let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
                         let x' = inp.x * f32.sgn inp.x
                         let (rng, xf) = dist.rand (1.5, 2.5) inp.rng
                         let (_rng, r) = dist.rand (x', x' * xf) rng
                         in speed_up center_dist (with_input (\inp -> (rotate inp.time (square r)))))

let color_on = const argb.white
let color_off = const argb.black
let name () = "spike_zoom"
