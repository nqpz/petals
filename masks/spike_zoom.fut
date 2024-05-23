import "../src/mask_base"

let mask' (inp: input) =
  let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
  let x' = inp.x * f32.sgn inp.x
  let (rng, xf) = dist.rand (1.5, 2.5) inp.rng
  let (_rng, r) = dist.rand (x', x' * xf) rng
  in speed_up center_dist (rotate (.time) (square r))

let mask = with_input mask'

let color_on = const argb.white
let color_off = const argb.black
let name () = "spike_zoom"
