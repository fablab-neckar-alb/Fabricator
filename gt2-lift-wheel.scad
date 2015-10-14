use <MCAD/nuts_and_bolts.scad>
use <Parametric_pulley/Pulley.scad>

// inner=9, outer=11 a bit loose on the thread
module GT2Thread(teeth=40, diameter=29, pulley_t_ht=7.5, top=2, bottom=2,
                 inner=8.5, outer=11.75, base=10, screw_height=6,
                 spacer_diameter=20, spacer_height=1,
                 overlap=0.123456789) {
  translate([0, 0, top + pulley_t_ht + base]) {
    rotate([0, 180, 0]) {
      color("Aquamarine") {
        difference() {
          Pulley(profile=12, teeth=teeth, no_of_nuts=0,
                 retainer=1, retainer_ht=top,
                 idler=1, idler_ht=bottom,
                 pulley_b_ht=base, pulley_b_dia = outer,
                 pulley_t_ht=pulley_t_ht, motor_shaft=inner);
          translate([0, 0, top + pulley_t_ht + base - screw_height])
            nutHole(8);
        }
      }
    }
  }
}

GT2Thread();
