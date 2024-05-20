import "../lib/github.com/diku-dk/lys/lys"
import "types"
import "random"

module type lys_input = {
  val pixel_mask: mask

  val pixel_color_on: color

  val pixel_color_off: color
}

type text_content = i32
module mk_lys (lys_input: lys_input): lys with text_content = text_content = {
  type state = {time: f32, rng: rng, h: i32, w: i32}

  let grab_mouse = false

  let init (seed: u32) (h: i64) (w: i64): state =
    {time=0, rng=rnge.rng_from_seed [i32.u32 seed],
     h=i32.i64 h, w=i32.i64 w}

  let resize (h: i64) (w: i64) (s: state): state =
    s with h = i32.i64 h with w = i32.i64 w

  let event (e: event) (s: state): state =
    match e
    case #step td -> s with time = s.time + td
    case _ -> s

  let render (s: state): [][]argb.colour =
    let size = r32 (i32.min s.h s.w)

    let render_pixel (yi: i32) (xi: i32): argb.colour =
      let inp = {time=s.time, rng=s.rng,
                 x=r32 (xi - s.w / 2) / size, y=r32 (yi - s.h / 2) / size}
      in if lys_input.pixel_mask inp
         then lys_input.pixel_color_on inp
         else lys_input.pixel_color_off inp

    in tabulate_2d (i64.i32 s.h) (i64.i32 s.w) (\y x -> render_pixel (i32.i64 y) (i32.i64 x))

  type text_content = text_content

  let text_format () = "FPS: %d"

  let text_content (render_duration: f32) (_: state): text_content =
    t32 render_duration

  let text_colour = const argb.green
}
