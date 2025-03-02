$fn=180;

module magnet() {
    difference() {
        cylinder(h=2.61,d=14.77);
        translate([0,0,-0.01]) cylinder(d=14.77-5.3*2, h=1.35+0.02);
        translate([0,0,1.35]) cylinder(d1=14.77-5.3*2, d2=14.77-4.17*2, h=2.61-1.35+0.01);
    }
    
}


module wallPart() {
    difference() {
        hull() {
            cube([20,5,20]);
            cube([20,20,5]);
        }
        hull() translate([14.77/2+2.5,2.60,14.77/2+2.5]) rotate([90,0,0]) magnet();
        hull() {
            translate([10,20,5]) cylinder(d=10,h=20);
            translate([10,11,5]) cylinder(d=10,h=20);
        }
        translate([10,11,-0.01]) cylinder(d=2,h=20);
    }
}

wallPart();