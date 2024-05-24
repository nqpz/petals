import "../src/mask_base"

let ring outer = square outer ^^^ square (outer - 0.05)

let animate_ring i =
  ring (i / 10)
  |> rotate (\inp -> inp.time + inp.x)
  |> speed_up (i / 2)

let mask = map_fold animate_ring (^^^) never (map r32 (5..>0))
           |> scale 0.6

let color_on (inp: input) = argb.from_rgba (f32.abs inp.y ** 0.5) (f32.abs inp.x ** 0.5) 1 1
let color_off = const argb.black
let name () = "squares in squares"
