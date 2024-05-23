import "../src/mask_base"

let mask' (inp: input) =
  let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
  let (_, r) = dist.rand (0.2, 0.3) inp.rng
  in square r
     |> rotate (.time)
     |> speed_up center_dist

let mask = with_input mask'

let color_on = const argb.white
let color_off = const argb.black
let name () = "distorted square rotate"
