import "types"

let (f: mask) &&& (g: mask): mask =
  \(inp: input) -> f inp && g inp

let (f: mask) ||| (g: mask): mask =
  \(inp: input) -> f inp || g inp

let scale (s: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x / s with y = inp.y / s)

let translate (x_off: f32) (y_off: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x - x_off with y = inp.y - y_off)

let rotate (angle: f32) (f: mask): mask =
  \(inp: input) -> f (inp with x = inp.x * f32.cos angle -
                                   inp.y * f32.sin angle
                          with y = inp.y * f32.cos angle +
                                   inp.x * f32.sin angle)

let speed_up (s: f32) (f: mask): mask =
  \(inp: input) -> f (inp with time = inp.time * s)

let time_offset (offset: f32) (f: mask): mask =
  \(inp: input) -> f (inp with time = inp.time - offset)

let fold [n] 'a (f: mask -> a -> mask) (acc: mask) (as: [n]a): mask =
  let f' inp b a = (f (const b) a) inp
  in \(inp: input) -> foldl (f' inp) (acc inp) as

let map_fold [n] 'a (f: a -> mask) (g: mask -> mask -> mask) (acc: mask) (as: [n]a): mask =
  let fg m a = g m (f a)
  in fold fg acc as

let with_input (f_inp: input -> mask): mask =
  \(inp: input) -> f_inp inp inp
