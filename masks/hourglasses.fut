import "../src/mask_base"

let mask = with_input (\(inp: input) ->
                         with_input (\inp -> show (inp.x * inp.y < 0.01 * f32.sin inp.time))
                         |> rotate (inp.time / 2))

let color_on = const argb.white
let color_off = const argb.black
let name () = "hourglasses"
