$fn=360;
h=16.41;
module shelf() {
    translate([-500,0,0]) color("white") cube([1000,1000,h]);
}

module extension() {
    hull() {
        translate([0,-6-56/2,-3]) cylinder(d=56,h+6);
        translate([0,10,(h+6)/2-3]) cube([56,56,h+6], center=true);
    }
}

difference() {
    extension();
    shelf();
}