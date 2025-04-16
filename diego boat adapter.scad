$fn=300;
e=0.01;

inch_per_mm=25.4;

height=1*inch_per_mm;
OD=(2 + 1/4)*inch_per_mm;
slot=3;
wire_hole_d = 1/4 * inch_per_mm;

module semicircle_adapter() {
    difference() {
        cylinder(d=OD,h=height);
        translate([0,0,-e]) cylinder(d=1 * inch_per_mm,h=height +e*2);
        translate([0,0,height/2]) rotate([0,90,0]) cylinder(d=wire_hole_d, h=OD/2+e);
        translate([slot/2,OD/2,-e]) rotate([0,0,180]) cube([OD/2+slot/2+e,OD+e*2,height+e*2]);
    }
}

module adapter() {
    difference() {
        cylinder(d=OD,h=height);
        translate([0,0,-e]) cylinder(d=1 * inch_per_mm,h=height +e*2);
        translate([-slot/2,0,-e]) cube([slot,OD/2+e,height+e*2]);
        increment = 45;
        for(angle = [90+increment :increment :360+increment ]) {
            translate([0,0,height/2]) rotate([0,90,angle]) cylinder(d=wire_hole_d, h=OD/2+e);
        }
    }
}

module test_rod() {
    color("grey", alpha=0.5) cylinder(d=1 * inch_per_mm, h=3 * height);
}

adapter();
//translate([0,0,-height]) test_rod();