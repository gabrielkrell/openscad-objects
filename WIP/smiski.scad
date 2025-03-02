$fn=120;

module smiski() {
    union() {
        translate([0,0,-1]) import("/home/gabe/Documents/3d printing/smiski-fixed.3mf");
        translate([3.1,0,8.5]) rotate([0,-14,0]) translate([0,0,.5]) cylinder(d=1.65, h=9);
        translate([3.1,0,8.5]) rotate([0,-14,0]) cylinder(d1=1, d2=1.65, h=.5);
        }
}

module back() {
    difference() {
        translate([-1,0,-1]) cube([11,3,18]);
        smiski();
    }
}

module front() {
    difference() {
        translate([-1,-3,-1]) cube([11,3,18]);
        smiski();
    }
}

smiski();