diff=16-10.8;

difference() {
    translate([0,-diff/2,-diff/2]) cube([16,16,16]);
    translate([-54/2,0,0]) cube([54,85.8,10.8]);
}

module tooth(d=20) {
    rotate([0,90,0]) rotate(-d) cylinder(r=1,h=16,$fn=1);
}

for (i = [0 : 1.25 : 5] ) {
    translate([0,16-diff/2-0.95,16-diff-.1]) translate([0,-i,0]) tooth();
    translate([0,16-diff/2-0.95,]) translate([0,-i,0]) tooth(30);
}