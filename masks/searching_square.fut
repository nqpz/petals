import "../src/mask_base"

let mask' (inp: input) =
  let a = f32.atan2 inp.y inp.x + f32.pi
  let f t = t % (2 * f32.pi)
  let start = f inp.time
  let end = f (f32.pi / 4 + inp.time)
  let corner = end < start
  in cond (((corner || a >= start) && a < end)
           || (a >= start && (corner || a < end)))
          (square 0.5) (circle 0.2)

let mask = with_input mask'

let color_on = const argb.white
let color_off = const argb.black
let name () = "searching_square"
