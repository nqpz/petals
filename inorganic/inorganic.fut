import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/random"
import "../src/lys_interoperability"

module distorted_square_rotate: lys_input = import "masks/distorted_square_rotate"
module spike_zoom: lys_input = import "masks/spike_zoom"
module flailing_polygon: lys_input = import "masks/flailing_polygon"
module random_squares: lys_input = import "masks/random_squares"
module xor_up_and_down: lys_input = import "masks/xor_up_and_down"
module searching_square: lys_input = import "masks/searching_square"
module dithered_star_clusters: lys_input = import "masks/dithered_star_clusters"
module hourglasses: lys_input = import "masks/hourglasses"

module lys = mk_lys hourglasses
