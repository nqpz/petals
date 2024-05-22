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

-- let flailing_polygon (inp: input) =
--   let rngs = rnge.split_rng 10 inp.rng
--   in map_fold (\rng ->
--                  let (rng, x) = dist.rand (-0.5, 0.5) rng
--                  let (rng, y) = dist.rand (-0.5, 0.5) rng
--                  let (_rng, s) = dist.rand (1, 8) rng
--                  in with_input (\inp -> square 0.6
--                                         |> rotate inp.time)
--                     |> translate x y
--                     |> speed_up s)
--               (&&&) always rngs

-- let random_squares (inp: input) =
--   let rngs = rnge.split_rng 10 inp.rng
--   in map_fold (\rng ->
--                  let (rng, x) = dist.rand (-0.5, 0.5) rng
--                  let (rng, y) = dist.rand (-0.5, 0.5) rng
--                  let (_rng, s) = dist.rand (1, 8) rng
--                  in with_input (\inp -> square 0.1
--                                         |> rotate inp.time)
--                     |> translate x y
--                     |> speed_up s)
--               (|||) never rngs

-- let xor_up_and_down (inp: input) =
--   scale 0.5 (circle (f32.abs (f32.sin inp.time))
--                     ^^^ square (f32.abs (f32.cos inp.time)))

-- let searching_square (inp: input) =
--   let a = f32.atan2 inp.y inp.x + f32.pi
--   let f t = t % (2 * f32.pi)
--   let start = f inp.time
--   let end = f (f32.pi / 4 + inp.time)
--   let corner = end < start
--   in cond (((corner || a >= start) && a < end)
--            || (a >= start && (corner || a < end)))
--           (square 0.35) (circle 0.2)

let mask (_: input) =
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
  in star2 ||| (translate 0 size star2)

module lys = mk_lys {
  let pixel_mask = with_input mask

  let pixel_color_on = const argb.white

  let pixel_color_off = const argb.black
}
