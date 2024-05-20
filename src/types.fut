import "../lib/github.com/athas/matte/colour"
import "random"

type input = {time: f32, rng: rng, x: f32, y: f32}
type^ mask = input -> bool
type^ color = input -> argb.colour
