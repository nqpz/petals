import "../lib/github.com/diku-dk/cpprandom/random"

module rnge = xorshift128plus
type rng = rnge.rng
module dist = uniform_real_distribution f32 rnge
