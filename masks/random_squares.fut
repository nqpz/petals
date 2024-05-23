import "../src/mask_base"

let mask' (inp: input) =
  let rngs = rnge.split_rng 10 inp.rng
  in map_fold (\rng ->
                 let (rng, x) = dist.rand (-0.5, 0.5) rng
                 let (rng, y) = dist.rand (-0.5, 0.5) rng
                 let (_rng, s) = dist.rand (1, 8) rng
                 in square 0.1
                    |> rotate (.time)
                    |> translate x y
                    |> speed_up s)
              (|||) never rngs

let mask = with_input mask'

let color_on = const argb.white
let color_off = const argb.black
let name () = "random_squares"
