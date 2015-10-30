include <Cylinder.scad>

length = 103;
width = 55;
bottom = 4.5;
wall = 2;
height = 10;
overlap=0.123456789;

nut_height = 2.5;
nut_size = 5.6;

layer = 0.01;

module Pin() {
    Cylinder(r=5 / 2, h=2);
    Cylinder(r=3 / 2, h=4);
}

module Hole(block=false) {
    if (block) {
        translate([-4, -4, 0])
            cube([8, 8, 2]);
    } else {
        difference() {
            union() {
                translate([0, 0, -1])
                    Cylinder(r=3 / 2, h=height + 2, outcircle=true, $fn=6);
                translate([0, 0, -overlap])
                    Cylinder(r=nut_size / 2, h=nut_height + overlap, outcircle=true, $fn=6);
            }
            translate([-nut_size, -nut_size, nut_height])
                cube([nut_size * 2, nut_size * 2, layer]);
        }
    }
}

pins = [[2.4, 15.2], [2.4, 90.3]];
holes = [[50.5, 14.0],[50.5, 96.7], [17.7, 66.0], [45.7, 66.0]];

difference() {
    union() {
        difference() {
            cube([width + 2 * wall, length + 2 * wall, height]);
            translate([wall, wall, bottom])
                cube([width, length, height - bottom + overlap]);
        }
        for (i = [0 : 1]) {
            translate([wall + pins[i][0], wall + pins[i][1], bottom])
                Pin();
        }

        for (i = [0 : 3]) {
            translate([wall + holes[i][0], wall + holes[i][1], bottom])
                Hole(block=true);
        }
    }
    for (i = [0 : 3]) {
        translate([wall + holes[i][0], wall + holes[i][1], 0])
            Hole();
    }
}

*difference() {
    union() {
        translate([-10, -10, 0])
            cube([20, 20, bottom]);
        translate([0, 0, bottom])
            Hole(block=true);
        translate([100, 0, 0])
            Pin();
    }
    Hole();
}

