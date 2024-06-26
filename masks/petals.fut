import "../src/mask_base"

let petal: mask =
  (circle 0.15 |> translate (-0.1) 0)
  &&& (circle 0.15 |> translate 0.1 0)

let multiple (n: i32) combine initial f =
  map_fold f combine initial (0..<n)

let petals (n: i32) (translated: f32): mask =
  let petal' = petal |> translate 0 translated
  in multiple n (|||) never
              (\i -> petal' |> rotate (const (r32 i * 2 * f32.pi / r32 n)))

let petal_groups (n: i32) (translated: f32): mask =
  let petals' =
    with_input (\(inp: input) ->
                  petals 10 (0.3 * f32.sin inp.time)
                  |> rotate (\inp -> inp.time / 10)
                  |> scale 0.5
                  |> translate 0 translated)
  in multiple n (|||) never
              (\i -> petals'
                     |> rotate (const (r32 i * 2 * f32.pi / r32 n))
                     |> time_offset (r32 i)
                     |> (let u = r32 i * 2 * f32.pi / r32 n
                         in speed_up (f32.cos u + f32.sin u)))

let mask = petal_groups 5 0.3
           |> rotate (\inp -> f32.sin (inp.time / 3))

let pixel_color_base (inp: input): f32 =
  (f32.cos inp.time + 1) / 3 + f32.sqrt (inp.x**2 + inp.y**2)

let color_on inp = argb.from_rgba (pixel_color_base inp) 0 0 1
let color_off inp = argb.from_rgba (1 - pixel_color_base inp) 0 0 1
let name () = "petals"
