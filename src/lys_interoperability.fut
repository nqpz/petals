import "../lib/github.com/diku-dk/lys/lys"
import "types"
import "random"

module type mask_picker = {
  val n_masks: i32

  val pick_mask: input -> i32 -> argb.colour

  val all_names: () -> string []
}

let get_color (inp: input) ((mask, color_on, color_off): mask_parts): argb.colour =
  if mask inp
  then color_on inp
  else color_off inp

module singleton_mask (mask: mask): mask_picker = {
  let n_masks = 1i32

  let pick_mask inp _ =
    get_color inp (mask.mask, mask.color_on, mask.color_off)

  let all_names () = mask.name ()
}

module add_mask (mask: mask) (prev_picker: mask_picker): mask_picker = {
  let n_masks = prev_picker.n_masks + 1

  let pick_mask inp i =
    if i == prev_picker.n_masks
    then get_color inp (mask.mask, mask.color_on, mask.color_off)
    else prev_picker.pick_mask inp i

  let all_names () = prev_picker.all_names() ++ "|" ++ mask.name ()
}

type text_content = (i32, i32)
module mk_lys (mask_picker: mask_picker): lys with text_content = text_content = {
  type state = {mask_i: i32, time: f32, rng: rng, h: i32, w: i32}

  let grab_mouse = false

  let init (seed: u32) (h: i64) (w: i64): state =
    let rng = rnge.rng_from_seed [i32.u32 seed]
    let (rng, mask_i) = dist_i32.rand (0, mask_picker.n_masks - 1) rng
    in {mask_i, time=0, rng, h=i32.i64 h, w=i32.i64 w}

  let resize (h: i64) (w: i64) (s: state): state =
    s with h = i32.i64 h with w = i32.i64 w

  let new_rng (s: state): rng =
    -- Hack: Spice up the rng with a poor source.
    let (_, seed) = rnge.rand s.rng
    in rnge.rng_from_seed [t32 (3007 * s.time) ^ i32.u64 seed]

  let keydown key (s: state): state =
    if key == SDLK_r
    then s with time = 0
           with rng = new_rng s
    else if key == SDLK_LEFT
    then s with mask_i = (s.mask_i - 1) % mask_picker.n_masks
    else if key == SDLK_RIGHT
    then s with mask_i = (s.mask_i + 1) % mask_picker.n_masks
    else s

  let event (e: event) (s: state): state =
    match e
    case #step td -> s with time = s.time + td
    case #keydown {key} -> keydown key s
    case _ -> s

  let render (s: state): [][]argb.colour =
    let size = r32 (i32.min s.h s.w)

    let render_pixel (yi: i32) (xi: i32): argb.colour =
      let inp = {time=s.time, rng=s.rng,
                 x=r32 (xi - s.w / 2) / size, y=r32 (yi - s.h / 2) / size}
      in mask_picker.pick_mask inp s.mask_i

    in tabulate_2d (i64.i32 s.h) (i64.i32 s.w) (\y x -> render_pixel (i32.i64 y) (i32.i64 x))

  type text_content = text_content

  let text_format () = "FPS: %d\nName: %[" ++ mask_picker.all_names () ++ "]"

  let text_content (render_duration: f32) (s: state): text_content =
    (t32 render_duration, s.mask_i)

  let text_colour = const argb.green
}
