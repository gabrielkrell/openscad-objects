$fn=360;
e=0.01;
e2=e*2;
thickness=2.5;

offset=4+(thickness-1.5);

difference() {
    cube([38,38,thickness]);
    translate([16+e,-e,-e]) cube([38-16,38-18,thickness+e2]); // big square cutout BR
    translate([-e,-e,-e]) cube([10+e2,10-thickness+e2+offset,thickness+e2]); // underneath tab
    translate([10+1.5+1.5,1.5+1.5,-e]) hull() { // slot below tab
        cylinder(d=3,h=thickness+e2);
        translate([0,3,0]) cylinder(d=3,h=thickness+e2);
    }
    translate([38-6-1.5,38-18+1.5+1.5,-e]) hull() { // slot near top
        cylinder(d=3,h=thickness+e2);
        translate([0,3,0]) cylinder(d=3,h=thickness+e2);
    }
    d=12; // deliberately oversize from 11 dia, 6.5 from edges
    translate([6+d/2,38-6-d/2,-e]) cylinder(d=d,h=thickness+e2); // big screw hole
    // actually, there's no functional reason for that curve at the top
}
difference() { //tab
    union() {
        translate([0,10-thickness+offset,-e]) cube([10,thickness,33.5]);
        hull() {
            translate([0,10-thickness+offset,-e]) cube([10,thickness,15]);
            translate([0,10-thickness+offset,-e]) cube([16,thickness,5]);
        }
    }
    // holes are 18mm apart
    translate([10/2,10+offset+e,1.5+5]) { // closest tab slot
        hull() { // through hole
            rotate([90,0,0]) cylinder(d=3,h=thickness+e2);
            translate([0,0,3]) rotate([90,0,0]) cylinder(d=3,h=thickness+e2);
        }
        hull() { // screw head space
            translate([0,0,0]) rotate([90,0,0]) cylinder(d=5.5,h=(thickness-1.5)+e2);
            translate([0,0,3]) rotate([90,0,0]) cylinder(d=5.5,h=(thickness-1.5)+e2);
        }
    }
    translate([10/2,10+offset+e,1.5+5+21]) {  // furthest tab slot
        hull() {
            rotate([90,0,0]) cylinder(d=3,h=thickness+e2);
            translate([0,0,3]) rotate([90,0,0]) cylinder(d=3,h=thickness+e2);
        }
        hull() { // screw head space
            translate([0,0,0]) rotate([90,0,0]) cylinder(d=5.5,h=(thickness-1.5)+e2);
            translate([0,0,3]) rotate([90,0,0]) cylinder(d=5.5,h=(thickness-1.5)+e2);
        }
        }
    translate([10/2,10+offset+e,2.5+16]) rotate([90,0,0]) cylinder(d=5,h=thickness+e2);
}

hull() {
    translate([0,10-thickness+offset,-e]) cube([16,thickness,5]);
    translate([0,10-thickness+offset,-e]) cube([16,5,thickness]);
}