import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/random"
import "../src/lys_interoperability"

let mask (inp: input) =
  let (_, r) = dist.rand (0.1, 0.4) inp.rng
  in rotate inp.time (square r)

module lys = mk_lys {
  let pixel_mask = with_input mask

  let pixel_color_on = const argb.white

  let pixel_color_off = const argb.black
}
