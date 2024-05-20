import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/lys_interoperability"

module lys = mk_lys {
  let pixel_mask =
    with_input (\inp -> rotate inp.time (square 0.1))

  let pixel_color_on = const argb.white

  let pixel_color_off = const argb.black
}
