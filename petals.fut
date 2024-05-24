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
module squares_in_squares: mask = import "masks/squares_in_squares"

module mask_picker =
  add_mask squares_in_squares
  (add_mask hourglasses
  (add_mask dithered_star_clusters
  (add_mask searching_square
  (add_mask xor_up_and_down
  (add_mask random_squares
  (add_mask flailing_polygon
  (add_mask spike_zoom
  (add_mask distorted_square_rotate
  (singleton_mask petals)
  ))))))))

module lys = mk_lys mask_picker
