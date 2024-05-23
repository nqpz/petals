import "../../lib/github.com/athas/matte/colour"
import "../../src/types"
import "../../src/operations"
import "../../src/shapes"
import "../../src/random"

let mask = with_input (\(inp: input) ->
                         let rngs = rnge.split_rng 10 inp.rng
                         in map_fold (\rng ->
                                        let (rng, x) = dist.rand (-0.5, 0.5) rng
                                        let (rng, y) = dist.rand (-0.5, 0.5) rng
                                        let (_rng, s) = dist.rand (1, 8) rng
                                        in with_input (\inp -> square 0.1
                                        |> rotate inp.time)
                                           |> translate x y
                                           |> speed_up s)
                                     (|||) never rngs)

let color_on = const argb.white
let color_off = const argb.black
