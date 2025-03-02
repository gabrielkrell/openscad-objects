$fn=360;

module dish() {    
    difference() {
        cylinder(d=143, h=34);
        translate([0,0,10]) cylinder(d=143-12, h=24.1);
    }
    translate([0,0,10]) cylinder(h=8, d=50);
}


difference() {
    union() {
        for (i = [0: 90: 180]) {
            rotate([0, 0, i]) translate([-149/2, -5, 34]) cube([149, 10, 16]);
        }
        intersection() {
            union() {
                translate([-130/2, -5, 0]) cube([130, 10, 34]);
                translate([-5, -130/2, 0]) cube([10, 130, 34]);
            }
            cylinder(d1=120,d2=130, h=34);
        }
    }
    dish();
    translate([0,0,36]) hull() dish();
}
