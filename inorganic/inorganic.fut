import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/random"
import "../src/lys_interoperability"

-- let distorted_square_rotate (inp: input) =
--   let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
--   let (_, r) = dist.rand (0.2, 0.3) inp.rng
--   in speed_up center_dist (with_input (\inp -> (rotate inp.time (square r))))

-- let spike_zoom (inp: input) =
--   let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
--   let x' = inp.x * f32.sgn inp.x
--   let (rng, xf) = dist.rand (1.5, 2.5) inp.rng
--   let (_rng, r) = dist.rand (x', x' * xf) rng
--   in speed_up center_dist (with_input (\inp -> (rotate inp.time (square r))))

let mask (inp: input) =
  let rngs = rnge.split_rng 10 inp.rng
  in map_fold (\rng ->
                 let (rng, x) = dist.rand (-0.5, 0.5) rng
                 let (rng, y) = dist.rand (-0.5, 0.5) rng
                 let (_rng, s) = dist.rand (1, 8) rng
                 in with_input (\inp -> square 0.1
                                        |> rotate inp.time)
                    |> translate x y
                    |> speed_up s)
              (|||) never rngs

module lys = mk_lys {
  let pixel_mask = with_input mask

  let pixel_color_on = const argb.white

  let pixel_color_off = const argb.black
}
