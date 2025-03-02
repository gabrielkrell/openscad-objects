$fn=240;

module outer_knob() {
    difference() {
        union() {
            cylinder(d1=15, d2=14, h=14.5);
            translate([0,0,14.5]) cylinder(d1=14, d2=12.5, h=.5);
        }
        for(i = [0: 360/27: 360]) {
        rotate([0,0,i])  translate([15/2, 0, 0])
            rotate([0, -1.76, 0]) translate([0,0,2]) {
                cylinder(d=1, h=13);
                sphere (d=1);
            }
        }
        translate([0, 0, 15-7]) cylinder(d=11, h=7.01);
        translate([0, 0, -0.01]) cylinder(d=3.5, h=15); // post 3.3
        translate([0, 0, -0.01]) cylinder(d=11, h=2);
        translate([0,0,5]) rotate([90, 0, 0]) cylinder(d=4.2, h=10);
    }
}

module inner_knob() {
    difference() {
        cylinder(d1=10, d2=8, h=12);
        translate([0,0,-.01]) cylinder(d=2.2, h=10);
        hull() {
            translate([-5, 6, 5]) rotate([0, 90, 0]) cylinder(r=3, h=10);
            translate([-5, 5, 12]) rotate([0, 90, 0]) cylinder(r=3, h=10);
        }
        
        hull() {
            translate([-5, -6, 5]) rotate([0, 90, 0]) cylinder(r=3, h=10);
            translate([-5, -5, 12]) rotate([0, 90, 0]) cylinder(r=3, h=10);
        }
            translate([0,0,4.2]) rotate([90, 0, 90]) cylinder(d=4.2, h=10);
    }
}

outer_knob();
//translate([0,0,15])
//inner_knob();