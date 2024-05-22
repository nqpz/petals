import "../lib/github.com/diku-dk/cpprandom/random"

module rnge = xorshift128plus
type rng = rnge.rng
module dist_i32 = uniform_int_distribution i32 rnge
module dist = uniform_real_distribution f32 rnge
