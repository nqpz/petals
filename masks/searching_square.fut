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

let color_on (inp: input) =
  let d = 1 - f32.sqrt (inp.x ** 2 + inp.y ** 2)
  in argb.from_rgba d d 0.5 1
let color_off = const argb.black
let name () = "searching square"
