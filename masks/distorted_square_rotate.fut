import "../src/mask_base"

let mask = with_input (\(inp: input) ->
                         let center_dist = f32.sqrt (inp.x ** 2 + inp.y ** 2)
                         let (_, r) = dist.rand (0.2, 0.3) inp.rng
                         in speed_up center_dist (with_input (\inp -> (rotate inp.time (square r)))))

let color_on = const argb.white
let color_off = const argb.black
let name () = "distorted_square_rotate"
