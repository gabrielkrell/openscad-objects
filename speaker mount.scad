e=0.01;
$fn=360;
module speaker() {
    translate([-45,-26,-100]) cube([90,26,200]);
    difference() {
        intersection() {
            translate([0,0,-100]) cylinder(d=82,h=200);
            translate([-50,0,-100]) cube([100,100,200]);
        }
        translate([0,41-2,10]) hull() {
            rotate([-90,0,0]) cylinder(d=20,h=10);
            translate([0,0,10]) rotate([-90,0,0]) cylinder(d=20,h=10);
        }
    }
    translate([0,41-2,20]) rotate([-90,0,0]) difference() {
        cylinder(d=10,h=1);
        translate([0,0,e]) cylinder(d=5,h=1+e*2);
    }
}

module hanger_speaker() {
    translate([0,41,10]) difference() {
        union() {
            translate([-10,1,-5]) cube([20,3,15]);
            translate([-10,1,-5]) cube([20,3,10]);
            translate([0,-1,10]) rotate([-90,0,0]) cylinder(d=20,h=5);
        }
        translate([0,-e,10]) rotate([-90,0,0]) cylinder(d1=5,d2=10,h=4+2*e);
        translate([0,-e-1,10]) rotate([-90,0,0]) cylinder(d=5,h=5+2*e);
    }
}





module hanger_speaker_side() {
    rotate([0,0,-45/2*3/4]) translate([0,-41-6,-5]) {
        hanger_speaker();
    }
    hull() {
        rotate([0,0,-45/2*3/4]) translate([0,-41-6,-5]) {        
            translate([0,41,10])
                translate([-10,1,-5]) cube([20,3,10]);
            }
        translate([-10,0,0]) cube([20,4,5]);
    }
    intersection() {
        translate([10,0,0]) rotate([180-10,0,180]) cube([20,4,10]);
        translate([-10,0,-10]) cube([20,4,10]);
    }
}

side_relief=.5;
module hanger_wall_side() {
    translate([-14,-4*0,0*10]) rotate([10,180,180]) cube([28,4,10]);
    translate([-14,-4,-10]) cube([28,4,10]);
    intersection() {
        translate([-14+4-side_relief,4,-10]) rotate([0,2,180]) cube([4,4,10]);
        translate([-14,0,-10]) cube([4,4,10]);
    }
    intersection() {
        translate([24-14+side_relief,0,-10]) rotate([0,2,0]) cube([4,4,10]);
        translate([24-14,0,-10]) cube([4,4,10]);
    }
    translate([-14,-4,-14]) cube([28,8,4]);
    difference() {
        translate([0,4,-14]) rotate([90,0,0]) difference() {
            cylinder(d=28,h=4);
            translate([-14,0,-e]) cube([28,20,4+2*e]);
        }
        translate([e,4+e,-14-5]) rotate([90,0,0]) cylinder(d=4.4,h=4+2*e);
    }
}


rotate([0,0,-45/2*3/4]) translate([0,-41-2,-5]) {
//    speaker();
}

translate([0,4,]) hanger_speaker_side();
//translate([0,4,-12]) hanger_wall_side();