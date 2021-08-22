import "lib/github.com/diku-dk/lys/lys"

type input = {time: f32, x: f32, y: f32}
type^ mask = input -> bool
type^ color = input -> argb.colour

let (f: mask) &&& (g: mask): mask =
  \(inp: input) -> f inp && g inp

let (f: mask) ||| (g: mask): mask =
  \(inp: input) -> f inp || g inp

let scale (s: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x / s with y = inp.y / s)

let translate (x_off: f32) (y_off: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x - x_off with y = inp.y - y_off)

let rotate (angle: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x * f32.cos angle -
                                   inp.y * f32.sin angle
                          with y = inp.y * f32.cos angle +
                                   inp.x * f32.sin angle)

let speed_up (s: f32) (f: mask): mask =
  \(inp: input) -> f (inp with time = inp.time * s)

let time_offset (offset: f32) (f: mask): mask =
  \(inp: input) -> f (inp with time = inp.time - offset)

let multiple (n: i32) (initial: bool) (combine: mask -> mask -> mask)
             (f_i: i32 -> mask): mask =
  \(inp: input) -> loop mask = initial
                   for i < n do combine (const mask) (f_i i) inp

let with_input (f_inp: input -> mask): mask =
  \(inp: input) -> f_inp inp inp

let circle (r: f32): mask =
  \(inp: input) -> f32.sqrt (inp.x**2 + inp.y**2) < r

let petal: mask =
  (circle 0.15 |> translate (-0.1) 0) &&& (circle 0.15 |> translate 0.1 0)

let petals (n: i32) (translated: f32): mask =
  let petal' = petal |> translate 0 translated
  in multiple n false (|||) (\i -> petal' |> rotate (r32 i * 2 * f32.pi / r32 n))

let petal_groups (n: i32) (translated: f32): mask =
  let petals' =
    with_input (\(inp: input) ->
                  petals 10 (0.3 * f32.sin inp.time)
                  |> rotate (inp.time / 10)
                  |> scale 0.5
                  |> translate 0 translated)
  in multiple n false (|||)
              (\i -> petals'
                     |> rotate (r32 i * 2 * f32.pi / r32 n)
                     |> time_offset (r32 i)
                     |> (let u = (r32 i * 2 * f32.pi / r32 n)
                         in speed_up (f32.cos u + f32.sin u)))

let pixel_mask: mask =
  with_input (\(inp: input) -> petal_groups 5 0.3 |> rotate (f32.sin (inp.time / 3)))

let pixel_color_base (inp: input): f32 =
  (f32.cos inp.time + 1) / 3 + f32.sqrt (inp.x**2 + inp.y**2)

let pixel_color_on: color =
  \(inp: input) -> argb.from_rgba (pixel_color_base inp) 0 0 1

let pixel_color_off: color =
  \(inp: input) -> argb.from_rgba (1 - pixel_color_base inp) 0 0 1

type text_content = i32
module lys: lys with text_content = text_content = {
  type state = {time: f32, h: i32, w: i32}

  let grab_mouse = false

  let init (_seed: u32) (h: i64) (w: i64): state =
    {time=0, h=i32.i64 h, w=i32.i64 w}

  let resize (h: i64) (w: i64) (s: state): state =
    s with h = i32.i64 h with w = i32.i64 w

  let event (e: event) (s: state): state =
    match e
    case #step td -> s with time = s.time + td
    case _ -> s

  let render (s: state): [][]argb.colour =
    let size = r32 (i32.min s.h s.w)

    let render_pixel (yi: i32) (xi: i32): argb.colour =
      let inp = {time=s.time, x=r32 (xi - s.w / 2) / size, y=r32 (yi - s.h / 2) / size}
      in if pixel_mask inp
         then pixel_color_on inp
         else pixel_color_off inp

    in tabulate_2d (i64.i32 s.h) (i64.i32 s.w) (\y x -> render_pixel (i32.i64 y) (i32.i64 x))

  type text_content = text_content

  let text_format () = "FPS: %d"

  let text_content (render_duration: f32) (_: state): text_content =
    t32 render_duration

  let text_colour = const argb.green
}
