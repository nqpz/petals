import "../src/mask_base"

let mask' (inp: input) =
  let rngs = rnge.split_rng 10 inp.rng
  in map_fold (\rng ->
                 let (rng, x) = dist.rand (-0.5, 0.5) rng
                 let (rng, y) = dist.rand (-0.5, 0.5) rng
                 let (_rng, s) = dist.rand (1, 8) rng
                 in square 0.6
                    |> rotate (.time)
                    |> translate x y
                    |> speed_up s)
              (&&&) always rngs

let mask = with_input mask'

let color_on (inp: input) = argb.from_rgba (f32.abs (f32.cos inp.time)) 0 0 1
let color_off (inp: input) = argb.from_rgba 0 (f32.abs (f32.sin inp.time)) 0 1
let name () = "flailing polygon"
