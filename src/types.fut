import "../lib/github.com/diku-dk/lys/lys"
import "random"

type input = {time: f32, rng: rng, x: f32, y: f32}
type^ mask = input -> bool
type^ color = input -> argb.colour

module type mask = {
  val mask: mask

  val color_on: color

  val color_off: color

  val name : () -> string []
}

type^ mask_parts = (mask, color, color)
