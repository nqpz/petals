import "../src/mask_base"

def next (n: i64): i64 =
  if n % 2 == 0
  then n / 2
  else 3 * n + 1

def f (n: i64): i64 =
  let (_, count) =
    loop (n, count) = (n, 0)
    while n > 1
    do (next n, count + 1)
  in count

def f' = i64.f32 >-> f >-> f32.i64

let mask =
  with_input
  (\(inp: input) ->
     (\(inp: input) -> f' (inp.time * f32.abs inp.x) < f' (inp.time * f32.abs inp.y))
     |> speed_up ( (inp.x**2 + inp.y**2) + f32.sqrt inp.time))


let color_on = (\(inp: input) -> argb.from_rgba 0 (0.9 + f32.cos inp.time * 0.1) 0 1)
let color_off = const argb.black
let name () = "collatz"
