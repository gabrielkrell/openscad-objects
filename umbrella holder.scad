$fn=360;

offset = 124/2 - 21 / 2;

module handle() {
    translate([0, 21-124/2, 28/2]) color("brown") union() rotate([0, 0, 50]) {
        rotate_extrude(angle=75)
            translate([offset, 0, 0]) resize([21, 28]) circle(d=100);
//        rotate([90,0,0]) linear_extrude(120)
//            translate([offset, 0, 0]) resize([21, 28]) circle(d=100);
    }
}

module thick_handle() {
    translate([0, 21-124/2, 28/2]) color("brown") union() rotate([0, 0, 50]) {
        rotate_extrude(angle=75) hull() {
            translate([offset, 0, 0]) resize([21, 28]) circle(d=100);
            translate([offset + 10, 0, 0]) resize([21, 28]) circle(d=100);
        }
//        rotate([90,0,0]) linear_extrude(120) hull() {
//            translate([offset, 0, 0]) resize([21, 28]) circle(d=100);
//            translate([offset + 10, 0, 0]) resize([21, 28]) circle(d=100);
//        }
    }
}

width=40;
thickness=35;

//#rotate([90,0,0]) translate([0, 15, (thickness-28)/2]) handle();
rotate([90,0,0]) difference() {
    union() {
        difference() {
            translate([-width/2, 0, 0]) cube([width,15 + 21/2,thickness]);
            translate([0, 15 + 21/2 - 0.5, thickness/2]) handle();
        }
        translate([-width/2, 0, 0]) cube([width,60,(thickness-28)/2]);
    }
    translate([0, 15, (thickness-28)/2]) thick_handle();
//    #translate([0, 15 + 5, (thickness-28)/2]) handle();
    translate([0,47,-0.01]) cylinder(d1=4,d2=10,h=(thickness-28)/2+0.02);
    translate([0, 59, -28/2]) handle();
}




//#translate([0, 15, (thickness-28)/2]) thick_handle();