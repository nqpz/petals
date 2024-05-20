import "types"
import "operations"

let circle (r: f32): mask =
  \(inp: input) -> f32.sqrt (inp.x**2 + inp.y**2) < r
