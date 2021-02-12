$fn=160;

x=48.8;
y=15;
r=298.68;
z=5;

module cutout() {
    intersection() {
        translate([-x/2,-y/2,-0.01]) cube([x,y,z-0.01]);
        translate([0,r-y/2,0]) cylinder(h=z,r=r,,$fn=360);
        translate([0,y/2-r,0]) cylinder(h=z,r=r,$fn=360);
    }
}


difference() {
    translate([-57/2,-30/2,0]) cube([57,30,14.97]);
    translate([0,0,10]) cutout();
    label();
}

module label() {
    translate([20,-2.5,1.99])
    rotate([0,180,0])
    linear_extrude(height=2) text(version, size=7);
}