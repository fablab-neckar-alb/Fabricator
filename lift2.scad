use <MCAD/nuts_and_bolts.scad>
use <Cylinder.scad>

overlap = 0.123456789;

gt2Radius = 9.5;
gt2Height = 7.5;
gt2ScrewRadius = 1.6;
gt2ScrewHeight = 4;

wallHeight=1;

nutHeight = 6.3;

height = nutHeight + wallHeight + gt2Height;
radius = 11;
bore = 8.5;
layer = 0.1;

difference() {
    Cylinder(r=radius, h=height, $fn=72);
    translate([0, 0, height - gt2Height])
        Cylinder(r=gt2Radius, h=gt2Height + overlap, outcircle=true, $fn=72);
    translate([0, 0, -overlap])
        nutHole(8);
    translate([0, 0, height - gt2Height + gt2ScrewHeight])
        rotate([-90, 0, 0])
            Cylinder(r=gt2ScrewRadius, h=radius + 5, outCircle=true, $fn=12);
    translate([0, 0, height - gt2Height + gt2ScrewHeight])
        rotate([0, 90, 0])
            Cylinder(r=gt2ScrewRadius, h=radius + 5, outCircle=true, $fn=12);
    translate([0, 0, nutHeight + 3 * layer])
        Cylinder(r=0.5 * bore, h=wallHeight, outCircle=true, $fn=36);
}
