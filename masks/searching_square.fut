import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"

let mask = with_input (\(inp: input) ->
                         let a = f32.atan2 inp.y inp.x + f32.pi
                         let f t = t % (2 * f32.pi)
                         let start = f inp.time
                         let end = f (f32.pi / 4 + inp.time)
                         let corner = end < start
                         in cond (((corner || a >= start) && a < end)
                                  || (a >= start && (corner || a < end)))
                                 (square 0.35) (circle 0.2))

let color_on = const argb.white
let color_off = const argb.black
let name () = "searching_square"
