import "../src/mask_base"

let mask' (inp: input) =
  let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
  let x' = inp.x * f32.sgn inp.x
  let (rng, xf) = dist.rand (1.5, 2.5) inp.rng
  let (_rng, r) = dist.rand (x', x' * xf) rng
  in square r
     |> rotate (.time)
     |> speed_up (center_dist * inp.time / 3)

let mask = with_input mask'

let color_on = const argb.green
let color_off = const argb.brown
let name () = "spike zoom"
