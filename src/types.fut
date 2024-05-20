import "../lib/github.com/athas/matte/colour"

type input = {time: f32, x: f32, y: f32}
type^ mask = input -> bool
type^ color = input -> argb.colour
