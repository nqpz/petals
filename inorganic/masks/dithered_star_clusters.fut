import "../../lib/github.com/athas/matte/colour"
import "../../src/types"
import "../../src/operations"
import "../../src/shapes"
import "../../src/random"

let mask =
  let size = 0.2
  let speed_max = 2
  let star = with_input (\inp ->
                           let point_rng = rnge.rng_from_seed [t32 (inp.x * 1000), t32 (inp.y * 1000)]
                           let rng = rnge.join_rng [inp.rng, point_rng]
                           let (rng, speed_a) = dist.rand (1, speed_max) rng
                           let (rng, speed_b) = dist.rand (1, speed_max) rng
                           let (_, c) = dist_i32.rand (0, 1) rng
                           let s = square size
                           let (a, b) = (speed_up speed_a (with_input (\inp -> rotate inp.time s)),
                                         speed_up speed_b (with_input (\inp -> rotate (-inp.time) s)))
                           in (cond (c == 0) a b) &&& (a ^^^ b))
  let star2 = star ||| translate size 0 star
  let star4 = star2 ||| (translate 0 size star2)
  in translate (-size / 2) (-size / 2) star4

let color_on = const argb.white
let color_off = const argb.black
