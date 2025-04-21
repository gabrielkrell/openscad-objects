module wedge() {
    hull() {
        cube([2,40,0.01], center=true);
        translate([0,0,10]) cube([14,40,0.01], center=true);
    }
}

module hollow_wedge() {
    wall = 1;
    bottom = 0.6;
    offset=2.3;
    translate([0,0,-offset]) difference() {
        hull() {
            cube([2,40,0.01], center=true);
            translate([0,0,10]) cube([14,40,0.01], center=true);
        }
        translate([0,0,bottom+offset]) hull() {
            cube([2,40-wall*2,0.01], center=true);
            translate([0,0,10]) cube([14-wall*2,40-wall*2,0.01], center=true);
        }
        translate([-30,-30,-0.01]) cube([60,60,offset]);
    }
}

module tray() {
    wall = 2;
    bottom = 0.6;
    inner = 50 - wall*2;
    difference() {
        translate([-25,-25,0]) cube([50,50,16]);
        translate([-inner/2,-inner/2,bottom]) cube([inner,inner,16]);
    }
}

module point() {
    hull() {
        translate([-5,0,0]) cylinder(d=5,h=10);
        translate([-5,40,0]) cylinder(d=5,h=10);
    }
    hull() {
        translate([5,0,0]) cylinder(d=5,h=10);
        translate([5,40,0]) cylinder(d=5,h=10);
    }
    hull() {
        translate([-5,0,0]) cylinder(d=5,h=10);
        translate([5,0,0]) cylinder(d=5,h=10);
    }
    hull() {
        translate([-2.5,0,0]) cube([5,0.01,10]);
        translate([-0.01,40,0]) cube([0.02,0.01,10]);
    }
}

$fn=120;
translate([0,20,0]) rotate([0,0,180]) point();
translate([35,0,0]) tray();
translate([-40,0,0]) wedge();
translate([-20,0,0]) hollow_wedge();