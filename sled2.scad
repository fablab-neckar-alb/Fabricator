use <Cylinder.scad>
use <bearing.scad>
use <hex.scad>
use <MCAD/nuts_and_bolts.scad>

module NutHole(size=8) {
    rotate([0, 0, 30])
        nutHole(size=size);
}

module Top(beam_distance=50, beam_diameter=8, beam_length=50, x_beam_clearance=1, bearing_diameter=15, bearing_length=24, pulley_height=12.0, pulley_diameter=25, holder_width=3, holder_height=2, screw=8, nut=14, wall=2, clearance=0.1, overlap=0.123456789) {
    width = beam_length + 2 * wall;
    length = beam_distance + beam_diameter + pulley_diameter + nut + 4 * wall;
    height = wall + pulley_height / 2 + max(beam_diameter / 2 + wall, pulley_height / 2) + wall + bearing_diameter / 2;
    split1 = height - pulley_height - wall;
    split2 = height - pulley_height / 2 - wall;
    rotate([180, 0, 0])
    translate([0, 0, -height])
    difference() {
        Sled(beam_distance=beam_distance, beam_diameter=beam_diameter, beam_length=beam_length, x_beam_clearance=x_beam_clearance, bearing_diameter=bearing_diameter, bearing_length=bearing_length, pulley_height=pulley_height, pulley_diameter=pulley_diameter, holder_width=holder_width, holder_height=holder_height, screw=screw, nut=nut, wall=wall, clearance=clearance, overlap=overlap);
        difference() {
            translate([-width / 2 - overlap, -length / 2 - overlap, -overlap])
                cube([width + 2 * overlap, length + 2 * overlap, split2 + overlap]);
            for(sign = [-1 : 2 : 1]) {
                translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall) + (sign - 1) / 2 * (nut / 2 + wall + overlap) - overlap, split1 + overlap])
                    cube([nut / 2 + wall + 3 * overlap, nut / 2  + wall + 3 * overlap, split2 - split1 + overlap]);
            }
        }
    }
}

module Middle(beam_distance=50, beam_diameter=8, beam_length=50, x_beam_clearance=1, bearing_diameter=15, bearing_length=24, pulley_height=12, pulley_diameter=25, holder_width=3, holder_height=2, screw=8, nut=14, wall=2, clearance=0.1, overlap=0.123456789) {
    width = beam_length + 2 * wall;
    length = beam_distance + beam_diameter + pulley_diameter + nut + 4 * wall;
    height = wall + pulley_height / 2 + max(beam_diameter / 2 + wall, pulley_height / 2) + wall + bearing_diameter / 2;
    split1 = height - pulley_height - wall;
    split2 = height - pulley_height / 2 - wall;
    //rotate([180, 0, 0])
    translate([0, 0, -split1])
    difference() {
        Sled(beam_distance=beam_distance, beam_diameter=beam_diameter, beam_length=beam_length, x_beam_clearance=x_beam_clearance, bearing_diameter=bearing_diameter, bearing_length=bearing_length, pulley_height=pulley_height, pulley_diameter=pulley_diameter, holder_width=holder_width, holder_height=holder_height, screw=screw, nut=nut, wall=wall, clearance=clearance, overlap=overlap);
        translate([-width / 2 - overlap, -length / 2 - overlap, -overlap])
            cube([width + 2 * overlap, length + 2 * overlap, split1 + overlap]);
        translate([-width / 2 - overlap, -length / 2 - overlap, split2])
            cube([width + 2 * overlap, length + 2 * overlap, height - split2 + overlap]);
        for(sign = [-1 : 2 : 1]) {
            translate([width / 2 - nut / 2 - wall - overlap, sign * (length / 2 - nut / 2 - wall) + (sign - 1) / 2 * (nut / 2 + wall + overlap) - overlap, split1])
                cube([nut / 2 + wall + 3 * overlap, nut / 2  + wall + 3 * overlap, split2 - split1 + overlap]);
        }
    }
}

module Bottom(beam_distance=50, beam_diameter=8, beam_length=50, x_beam_clearance=1, bearing_diameter=15, bearing_length=24, pulley_height=12, pulley_diameter=25, holder_width=3, holder_height=2, screw=8, nut=14, wall=2, clearance=0.1, overlap=0.123456789) {
    width = beam_length + 2 * wall;
    length = beam_distance + beam_diameter + pulley_diameter + nut + 4 * wall;
    height = wall + pulley_height / 2 + max(beam_diameter / 2 + wall, pulley_height / 2) + wall + bearing_diameter / 2;
    split1 = height - pulley_height - wall;
    split2 = height - pulley_height / 2 - wall;
    rotate([180, 0, 0])
    translate([0, 0, -split1])
    difference() {
        Sled(beam_distance=beam_distance, beam_diameter=beam_diameter, beam_length=beam_length, x_beam_clearance=x_beam_clearance, bearing_diameter=bearing_diameter, bearing_length=bearing_length, pulley_height=pulley_height, pulley_diameter=pulley_diameter, holder_width=holder_width, holder_height=holder_height, screw=screw, nut=nut, wall=wall, clearance=clearance, overlap=overlap);
        translate([-width / 2 - overlap, -length / 2 - overlap, split1])
            cube([width + 2 * overlap, length + 2 * overlap, height - split1 + overlap]);
    }
}

module Sled(beam_distance=50, beam_diameter=8, beam_length=50, x_beam_clearance=1, bearing_diameter=15, bearing_length=24, pulley_height=12, pulley_diameter=25, holder_width=3, holder_height=2, screw=8, nut=14, wall=2, clearance=0.1, overlap=0.123456789) {
    width = beam_length + 2 * wall;
    length = beam_distance + beam_diameter + pulley_diameter + nut + 4 * wall;
    height = wall + pulley_height / 2 + max(beam_diameter / 2 + wall, pulley_height / 2) + wall + bearing_diameter / 2;
    bearing_x = -width / 2 + nut + wall * 2 + bearing_diameter / 2;
    split1 = height - pulley_height - wall;
    split2 = height - pulley_height / 2 - wall;
    echo(width=width, length=length, height=height, split1=split1, split2=split2);
    difference() {
        intersection() {
            translate([-width / 2, -length / 2, 0])
                cube([width, length, height]);
            union() {
                translate([-width / 2, -length / 2, 0])
                    Box(width=width, length=length, height=height);
                // X beam wall
                translate([bearing_x - beam_diameter  / 2 - wall, -length / 2, 0])
                    cube([beam_diameter + 2 * wall, length, max(bearing_diameter / 2 + wall, split1)]);
                for(sign = [-1 : 2: 1]) {
                    // Y beam walls
                    translate([-width / 2, -beam_diameter / 2 - wall + sign * beam_distance / 2, height - pulley_height - wall])
                        cube([width, beam_diameter + 2 * wall, pulley_height + wall]);
                    // bearing wall
                    translate([bearing_x - bearing_diameter / 2 - wall, sign * beam_distance / 2 - bearing_length / 2 - wall, 0])
                        cube([bearing_diameter + 2 * wall, bearing_length + 2 * wall, max(bearing_diameter / 2 + wall, split1)]);
                    // bearing holder wall
                    translate([bearing_x, sign * beam_distance / 2, 0])
                        rotate([90, 0, 0])
                            Cylinder(r=bearing_diameter / 2 + 2 * wall + holder_height, h=2 * wall + holder_width, center=true);
                            // pulleys
                    translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), -overlap])
                        Cylinder(r=screw/2 + wall, h=height + 2 * overlap);
                    translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), height - pulley_height - 2 * wall])
                        Cylinder(r=pulley_diameter/2 + wall, h=pulley_height + 2 * wall);
                    translate([width / 2 - nut / 2 - wall - pulley_diameter / 2 - wall, sign * length / 2 - (sign + 1) / 2 * (nut / 2 + wall), height - pulley_height - 2 * wall])
                        cube([pulley_diameter + 2 * wall, nut / 2 + wall, pulley_height + 2 * wall]);
                    translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall) - pulley_diameter / 2 - wall, height - pulley_height - 2 * wall])
                        cube([nut / 2 + wall, pulley_diameter + 2 * wall, pulley_height + 2 * wall]);
                    // pulley nut walls
                    translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), -overlap])
                        NutHole(size=screw + wall);
                    // central screws
                    translate([sign * (width / 2 - nut / 2 - wall), 0, 0])
                        Cylinder(r=screw / 2 + wall, h=height);
                    translate([sign * (width / 2 - nut / 2 - wall), 0, 0])
                        NutHole(size=screw + wall);
                    translate([sign * (width / 2 - nut / 2 - wall), 0, split1])
                        rotate([180, 0, 0])
                            NutHole(size=screw + wall);
                }
            }
        }
        // X beam
        translate([bearing_x, length / 2 + overlap, 0])
            rotate([90, 0, 0])
                Cylinder(r=beam_diameter / 2 + x_beam_clearance, h=length + 2 * overlap);
        for(sign = [-1 : 2: 1]) {
            // Y beams
            translate([-width / 2 + 2 * wall, sign * beam_distance / 2, height - pulley_height / 2 - wall])
                rotate([0, 90, 0])
                    Cylinder(r=beam_diameter / 2 + clearance / 2, h=beam_length + overlap);
            // bearings
            translate([bearing_x, sign * beam_distance / 2, 0])
                rotate([90, 0, 0])
                    Cylinder(r=bearing_diameter / 2 + clearance / 2, h=bearing_length + 2 * clearance, outcircle=true, center=true);
            // bearing holder
            translate([bearing_x, sign * beam_distance / 2, 0])
                rotate([90, 0, 0])
                    difference() {
                        Cylinder(r=bearing_diameter / 2 + wall + holder_height + clearance / 2, h=holder_width, center=true);
                        translate([0, 0, -overlap])
                            Cylinder(r=bearing_diameter / 2 + wall - clearance / 2, h=holder_width + 2 * overlap, center=true);
                    }
            // pulleys
            translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), -overlap])
                Cylinder(r=screw/2, h=height + 2 * overlap);
            translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), height - pulley_height - wall])
                Cylinder(r=pulley_diameter/2, h=pulley_height);
            translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall) - (sign + 1) / 2 * pulley_diameter / 2, height - pulley_height - wall])
                cube([nut / 2 + wall + overlap, pulley_diameter / 2, pulley_height]);
            translate([width / 2 - nut / 2 - wall - pulley_diameter / 2, sign * length / 2 - overlap - (sign + 1) / 2 * (nut / 2 + wall - overlap), height - pulley_height - wall])
                cube([pulley_diameter / 2, nut / 2 + wall + overlap, pulley_height]);
            // pulley nuts
            translate([width / 2 - nut / 2 - wall, sign * (length / 2 - nut / 2 - wall), -overlap])
                NutHole(size=screw);
            // central screws
            translate([sign * (width / 2 - nut / 2 - wall), 0, -overlap])
                Cylinder(r=screw/2, h=height + 2 * overlap);
            translate([sign * (width / 2 - nut / 2 - wall), 0, -overlap])
                NutHole(size=screw);
        }
    }
}

/* Top */
translate([-27, -38, 0])
    cylinder(r=5, h=0.15);
translate([27, -38, 0])
    cylinder(r=5, h=0.15);
translate([27, 0, 0])
    cylinder(r=5, h=0.15);
translate([-27, 0, 0])
    cylinder(r=5, h=0.15);
translate([27, 38, 0])
    cylinder(r=5, h=0.15);
translate([-27, 38, 0])
    cylinder(r=5, h=0.15);
Top(beam_distance=40, beam_diameter=10, bearing_diameter=19, bearing_length=29, wall=2, pulley_diameter=24);
/**/

/* Middle
translate([-27, -38, 0])
    cylinder(r=5, h=0.15);
translate([7, -38, 0])
    cylinder(r=5, h=0.15);
translate([17, -28, 0])
    cylinder(r=5, h=0.15);
translate([27, -18, 0])
    cylinder(r=5, h=0.15);
translate([27, 18, 0])
    cylinder(r=5, h=0.15);
translate([17, 28, 0])
    cylinder(r=5, h=0.15);
translate([7, 38, 0])
    cylinder(r=5, h=0.15);
translate([-27, 38, 0])
    cylinder(r=5, h=0.15);

//translate([60, 0, 0])
Middle(beam_distance=40, beam_diameter=10, bearing_diameter=19, bearing_length=29, wall=2, pulley_diameter=24);
*/

/* Bottom
translate([-27, -38, 0])
    cylinder(r=5, h=0.15);
translate([27, -38, 0])
    cylinder(r=5, h=0.15);
translate([-27, 38, 0])
    cylinder(r=5, h=0.15);
translate([27, 38, 0])
    cylinder(r=5, h=0.15);

//translate([120, 0, 0])
Bottom(beam_distance=40, beam_diameter=10, bearing_diameter=19, bearing_length=29, wall=2, pulley_diameter=24);
*/