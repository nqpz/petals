import "types"
import "operations"

let never: mask = const false

let always: mask = const true

let show (c: bool): mask = cond c always never

let circle (r: f32): mask =
  \(inp: input) -> f32.sqrt (inp.x**2 + inp.y**2) < r

let square (r: f32): mask =
  \(inp: input) -> inp.x > -r && inp.x < r && inp.y > -r && inp.y < r
