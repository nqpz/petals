import "../src/mask_base"

let mask' (inp: input) =
  scale 0.5 (circle (f32.abs (f32.sin inp.time))
                    ^^^ square (f32.abs (f32.cos inp.time)))

let mask = with_input mask'

let color_on = const argb.white
let color_off = const argb.black
let name () = "xor_up_and_down"
