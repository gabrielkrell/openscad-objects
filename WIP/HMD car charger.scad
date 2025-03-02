
caselength=162.5;
module HMD() { // phone with case. rough model for visualization
    color("#666666") cube([caselength, 78.75, 11.7]);
    color("#444444") translate([5, 5.5, 11.7]) cube([44.75,36.75,2.25]);
}

module chargerHolder(ring=true) {
    d2=61.15;
    d1=54.6;
    sideOffset = (9.3+8.8)/2; // snap position avg
    bottomOffset = (34.65+33.14)/2; // snap position avg
    translate([caselength-bottomOffset-d2/2, sideOffset+d2/2, 11.7+2.25]) {
//        cylinder(d2=d2, d1=54.6, h=4.56);
//        cylinder(d=54, h=1);
        difference() {
            cylinder(d2=d2, d1=d1, h=4.56);
            translate([0,0,1]) cylinder(d=d1, h=4.56);
        }
        translate([0,0,1.01]) difference() { // 1.5mm inner ring
            cylinder(h=1.5, d=45);
            translate([0,0,-.1]) cylinder(h=2, d=44);
        }
        if(ring) translate([0,0,1.01]) difference() { // magnet ring
            color("silver") cylinder(d=d1, h=3);
            translate([0,0,-.1]) cylinder(d=45, h=5);
            slice_angle = 25; // asin((11/2)/ (47/2));
            echo(slice_angle=slice_angle);
            rotate([0,0,-slice_angle /2])
            rotate_extrude(angle=slice_angle , convexity=1) { square([d2/2, 5.5]); }
        }
    }
    // 1.5 until ring, ring 3mm deep, outer wall is 1mm thick. likely all walls are 1mm
}

module chargerPCB() {
    sideOffset = (9.3+8.8)/2; // snap position avg
    bottomOffset = (34.65+33.14)/2; // snap position avg
    d2=61.15;
    d1=54.6;
    center_x = caselength-bottomOffset-d2/2;
    center_y = sideOffset+d2/2;
    translate([center_x, center_y, 11.7+2.25+1+1]) {
        difference() {
            color("#ffa267", alpha=0.5) cylinder(d=39, h=.999); // coil
            translate([0,0,-0.01]) cylinder(d=20, h=1.01);
        }
        color("#666666", alpha=1) cylinder(d=20, h=.999); // ferrite center
    }
    translate([center_x, center_y, 11.7+2.25+1+2]) {
        color("#666666", alpha=0.5) cylinder(d=42, h=.999); // ferrite
    }
    color("#666666", alpha=0.5) translate([center_x, center_y, 11.7+2.25+1+3]) {
        cylinder(d=53.5, h=1); // FR4
        translate([53.5/2-3.16-1, -(9+4)/2, 0]) linear_extrude(1) minkowski() {
            square([3.16, 9+4]); // little tab
            circle(2);
        }
    }
    
    translate([center_x+45/2, center_y-9/2, 11.7+1+3]) {
        color("silver") cube([3.16, 9, 6.8]); // USB-c port
    }
}


module chargerBack() {
    sideOffset = (9.3+8.8)/2; // snap position avg
    bottomOffset = (34.65+33.14)/2; // snap position avg
    d2=61.15;
    d1=54.6;
    center_x = caselength-bottomOffset-d2/2;
    center_y = sideOffset+d2/2;
    
    wall_thickness=2;
    color("#aa66ff", alpha=.3) {
        difference() {
            translate([0,0,11.7+5+2.25]) cube([caselength, 78.75, 1]);
            translate([center_x+45/2-1, center_y-11/2, 11.7+4]) cube([5.16, 11, 6.8]);
        }
        translate([0,0,0]) cube([wall_thickness, 78.75, 11.7+2.25+5]);
        translate([0,-wall_thickness,0]) cube([caselength, wall_thickness, 11.7+5+2.25]);
        translate([0,78.75,0]) cube([caselength, wall_thickness, 11.7+5+2.25]);
        
        translate([0,0,-1]) cube([caselength, 78.75, 1]);
    }
}

translate([100-$t*100, 0,
    $t > .80 ? (
        $t > .85
            ? 2.25
            : (2.25 * ($t-.80)/.05))
        : 0])
    HMD();
difference() {
    chargerHolder(ring=true);
    chargerPCB();
}
chargerPCB();
chargerBack();

module fanRails() {
    color("#aa66ff") {
        difference() {
            union() {
                translate([0,-4,0]) cube([40,4,10]);
                translate([20,-4,10]) cube([20,8,4]);
                translate([0,40,0]) cube([40,4,10]);
                translate([20,40-4,10]) cube([20,8,4]);
            }
            translate([20,20,0]) cylinder(d=40, h=12);
        }
        translate([20,40-4,-4]) cube([20,8,4]);
        translate([20,-4,-4]) cube([20,8,4]);
    }
}
translate([40,78.75/2-20,-10]) rotate([180,-15,180]) fanRails();

module fan() {
    color("#333333", alpha=0.5) difference() {
        union() {            
        translate([20,20,0]) cylinder(d=40, h=12);
            hull() {
                translate([0,2,0]) cube([2,36,10]);
                translate([38,2,0]) cube([2,36,10]);
                translate([2,0,0]) cube([36,2,10]);
                translate([2,38,0]) cube([36,2,10]);
            }
        }
        translate([4,4,-1]) cylinder(d=3.5, h=12);
        translate([4,36,-1]) cylinder(d=3.5, h=12);
        translate([36,4,-1]) cylinder(d=3.5, h=12);
        translate([36,36,-1]) cylinder(d=3.5, h=12);
    }
}
translate([40,78.75/2-20,-10]) rotate([180,-15,180]) fan();


//$fn=360;

module magnetHolderTest() { // note - prints fine on "faster prints". clean up ring with acetone before final installation
    d2=61.15;
    d1=54.6;
    difference() {
        cylinder(d2=d2, d1=d1, h=4.56);
        translate([0,0,1]) cylinder(d=d1, h=4.56);
        translate([0,0,-.1]) cylinder(h=2, d=44);
    }
    translate([0,0,1.01]) difference() { // 1.5mm inner ring
        cylinder(h=1.5, d=45);
        translate([0,0,-.1]) cylinder(h=2, d=44);
    }
}