$fn=180;
hole_d=7.15;

module plate_hole() {
    hull() {
        circle(d=hole_d);
        translate([11.10-hole_d,0]) circle(d=hole_d);
    }
}

hole_dist=177;
module holes() {
    plate_hole();
    translate([hole_dist,0]) plate_hole();
}

difference() {
    hull() {
        cylinder(d=hole_d*2, h=3);
        translate([hole_dist+hole_d/2,0]) cylinder(d=hole_d*2, h=3);
    }
    translate([0,0,-1]) linear_extrude(5) holes();
}



module plate() {
    square([40,22]);
}


translate([(hole_d+hole_dist)/2-20,hole_d-0.02,0]) linear_extrude(3) plate();