$fn=190;
thickness=3.5;

module hash() {
    linear_extrude(height=2) text(version, size=10);
}

module semi(d=999) {
    d=d+1;
    s=0.001;
    difference()
    {
        children();
        translate([-d/2,0,-s])
            cube([d,d,d+s]);
    }
        
}
module flat(major=80, depth_ = 62) {
    minor=80*2/3;
    offset = major/2-minor/2;

    projection(cut=true) hull() {
    semi(major) cylinder(h=depth_, d=major);
        translate([-offset,offset+1,0])
            rotate(180) semi(depth_) cylinder(h=depth_, d=minor);
        translate([offset,offset+1,0])
            rotate(180) semi(depth_) cylinder(h=depth_, d=minor);
        }
}

module cupholder(major=80, depth = 62) {
    hull() {
        linear_extrude(0.0001) flat(major-5.1, depth);
        translate([0,0,depth]) linear_extrude(0.0001) flat(major, depth);
    }
}

module hole() {
    cylinder(d=7, h=100, center=true, $fn=4);
}

module base() {
    difference() {
        cupholder();
        translate([0,0,thickness]) cupholder(80-thickness, 62.001-thickness);
        translate([0,0,55]) rotate([0,0,30]) {
            rotate([90,0,0]) hole();
            rotate([90,0,60]) hole();
            rotate([90,0,120]) hole();
            rotate([90,0,120]) hole();
        }
    color("black") rotate([0,180,0]) translate([-22,0,-2]) hash();
    }
    notch();
}

module notch(major=80, depth = 62) {
    minor=80*2/3;
    offset = major/2-minor/2;

    box_height=22;
    box_top_width=23.6;
    box_bottom_width=21.8; // key width 22, didn't quite fit. guess with some trig
    box_depth=20;

    translate([-box_bottom_width/2,major/2,depth-box_height])
    hull() {
        linear_extrude(0.001) square([box_bottom_width, box_depth]);
        translate([-box_top_width/2+box_bottom_width/2,0,box_height])
        linear_extrude(0.001) square([box_top_width, box_depth]);
    }
}


module bottle(actual=false) {
    if (actual == true) {
        color("#7be8d6") cylinder(d=91.37,h=215);
    } else {
        color("#7be8d6") cylinder(d=91.37+2,h=215); // add 2mm to avoid succ
    }
    color("black") translate([0,0,215]) cylinder(h=25,d=70);
}

module bottleHolder() {
    difference() {
        cylinder(d=91.37+2+3, h=62);
        bottle();
        thruhole();
        translate([0,0,5]) {
            rotate([90,0,0]) hole();
            rotate([90,0,60]) hole();
            rotate([90,0,120]) hole();
            rotate([90,0,120]) hole();
        }
    }
}

module thruhole() {    
    translate([0,0,-thickness*3.0001]) linear_extrude(thickness*3.0002) projection()
    translate([0,0,-2*(62.0001-thickness)])
    cupholder(80-thickness, 62.0001-thickness);
}

module joint() {
    difference() {
        hull() {
            linear_extrude(0.0001) projection() bottleHolder();
            translate([0,0,-2*thickness]) linear_extrude(0.001) flat();
        }
        thruhole();
    }
}


base();
//translate([0,0,62+2*thickness]) bottle(actual=true);
translate([0,0,62+2*thickness]) bottleHolder();
translate([0,0,62+2*thickness]) joint();

//notch();

//difference() {
//    union() {
//        base();
//        translate([0,100,0]) rotate(180) base();
//    }
//    #notch();
//}