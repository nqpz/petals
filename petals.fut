import "lib/github.com/athas/matte/colour"
import "src/types"
import "src/operations"
import "src/shapes"
import "src/random"
import "src/lys_interoperability"

module petals: mask = import "masks/petals"
module distorted_square_rotate: mask = import "masks/distorted_square_rotate"
module spike_zoom: mask = import "masks/spike_zoom"
module flailing_polygon: mask = import "masks/flailing_polygon"
module random_squares: mask = import "masks/random_squares"
module xor_up_and_down: mask = import "masks/xor_up_and_down"
module searching_square: mask = import "masks/searching_square"
module dithered_star_clusters: mask = import "masks/dithered_star_clusters"
module hourglasses: mask = import "masks/hourglasses"

module lys = mk_lys petals
