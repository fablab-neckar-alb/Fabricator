// number of faces n a circle (adapted from C code)
function get_fragments_from_r(r) =
    ($fn > 0) ? (($fn >= 3) ? $fn : 3) // at least 3 faces if fn is set
    : ceil(max(min(360 / $fa, 2 * PI * r / $fs), 5));

// Generate cylinder that fits inside a circle or radius r if outcircle is
// false and outside if outcircle is true. This prevents holes from being to
// small.
module Cylinder(r=1, r1=-1, r2=-1, h=1, outcircle=false, center=false) {
    r1_ = (r1 >= 0) ? r1 : r;
    r2_ = (r2 >= 0) ? r2 : r1_;
    n = max(get_fragments_from_r(r1_), get_fragments_from_r(r2_));
    r1__ = outcircle ? r1_ / cos(180 / n) : r1_;
    r2__ = outcircle ? r2_ / cos(180 / n) : r2_;
    cylinder(r1=r1__, r2=r2__, h=h, center=center, $fn=n);
}
