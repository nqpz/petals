import "../lib/github.com/diku-dk/lys/lys"
import "types"
import "random"

module type lys_input = {
  val mask: mask

  val color_on: color

  val color_off: color

  val name : () -> string []
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

  let new_rng (s: state): rng =
    -- Hack: Spice up the rng with a poor source.
    let (_, seed) = rnge.rand s.rng
    in rnge.rng_from_seed [t32 (3007 * s.time) ^ i32.u64 seed]

  let event (e: event) (s: state): state =
    match e
    case #step td ->
      s with time = s.time + td
    case #keydown {key} ->
                      if key == SDLK_r
                      then s with time = 0
                             with rng = new_rng s
                      else s
    case _ -> s

  let render (s: state): [][]argb.colour =
    let size = r32 (i32.min s.h s.w)

    let render_pixel (yi: i32) (xi: i32): argb.colour =
      let inp = {time=s.time, rng=s.rng,
                 x=r32 (xi - s.w / 2) / size, y=r32 (yi - s.h / 2) / size}
      in if lys_input.mask inp
         then lys_input.color_on inp
         else lys_input.color_off inp

    in tabulate_2d (i64.i32 s.h) (i64.i32 s.w) (\y x -> render_pixel (i32.i64 y) (i32.i64 x))

  type text_content = text_content

  let text_format () = "FPS: %d"

  let text_content (render_duration: f32) (_: state): text_content =
    t32 render_duration

  let text_colour = const argb.green
}
