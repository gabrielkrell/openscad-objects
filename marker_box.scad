$fn=180;

module marker() {
    color("red") cube([13,12,24]);
    color("white") translate([13/2,12/2,24]) cylinder(d=9.5,h=83);
}

module marker_bound() {
    spacer=0.5;
    cube([13+spacer*2,12+spacer*2,24+83]);
}

module markers() {
    spacing=14;
    marker();
    translate([spacing,0,0]) marker();
    translate([spacing*2,0,0]) marker();
    translate([spacing*3,0,0]) marker();
}


module magnet() {
    difference() {
        cylinder(h=2.61,d=14.77);
        translate([0,0,-0.01]) cylinder(d=14.77-5.3*2, h=1.35+0.02);
        translate([0,0,1.35]) cylinder(d1=14.77-5.3*2, d2=14.77-4.17*2, h=2.61-1.35+0.01);
    }
    
}


module markerspacers() {
    spacing=13.999;
    union() {
        marker_bound();
        translate([spacing,0,0]) marker_bound();
        translate([spacing*2,0,0]) marker_bound();
        translate([spacing*3,0,0]) marker_bound();
    }
}

module box() {
    difference() {
        wall=2;
        translate([-wall,-wall,-wall]) cube([14*4+wall*2,14+wall*3,30]);
        markerspacers();
        translate([12,14+wall*2+0.01,15-wall]) rotate([90,0,0]) hull() magnet();
        translate([14*4-12,14+wall*2+0.01,15-wall]) rotate([90,0,0]) hull() magnet();
    }
}

box();
//markers();
