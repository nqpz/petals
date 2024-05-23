import "../lib/github.com/athas/matte/colour"
import "../src/types"
import "../src/operations"
import "../src/shapes"
import "../src/random"
import "../src/lys_interoperability"

module distorted_square_rotate = import "masks/distorted_square_rotate"
module spike_zoom = import "masks/spike_zoom"
module flailing_polygon = import "masks/flailing_polygon"
module random_squares = import "masks/random_squares"
module xor_up_and_down = import "masks/xor_up_and_down"
module searching_square = import "masks/searching_square"
module dithered_star_clusters = import "masks/dithered_star_clusters"
module hourglasses = import "masks/hourglasses"

module lys = mk_lys hourglasses
