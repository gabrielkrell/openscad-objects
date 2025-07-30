$fn=240;
in = 25.4;
e=0.01;

color("grey") {
//translate([-10,50,0]) rotate([0,90,0]) cylinder(d=4,h=20);
//translate([-10,-50,0]) rotate([0,90,0]) cylinder(d=4,h=20);
//translate([0,-35/2,-9]) cube([15.5,35,50]);
}

module screen() {
    color("grey", alpha=0.5) translate([85-21,-21*in/2,4]) cube([21,21*in,12.5*in]); // 21 x 12.5 x 21m,m; 
}

module focusrite(shell=0,depth=0) {
    
    focusrite_h=47.5+shell; // without feet, 45.2;
    focusrite_d=85+depth;
    focusrite_l=175+2+shell;

    cr = 6.5; // focusrite corner radius
    y_offset=(focusrite_l-cr*2)/2;
    z_offset=(focusrite_h-cr*2)/2;

    hull() {
        translate([0,y_offset,z_offset]) rotate([0,90,0]) cylinder(h=focusrite_d, r=cr);
        translate([0,-y_offset,z_offset]) rotate([0,90,0]) cylinder(h=focusrite_d, r=cr);
        translate([0,y_offset,-z_offset]) rotate([0,90,0]) cylinder(h=focusrite_d, r=cr);
        translate([0,-y_offset,-z_offset]) rotate([0,90,0]) cylinder(h=focusrite_d, r=cr);
    }
    
    if (depth>0) {
        translate([-50,(focusrite_l-shell)/2-36-15/2,10-(focusrite_h-shell)/2-7.5/2]) cube([60,15,7.5]);
        translate([-50,-(focusrite_l-shell)/2+56.5-34.5/2,15-(focusrite_h-shell)/2-14/2]) cube([60,34.5,14]);
    }
    
    // usb is 36mm from the left, 10mm from the bottom; 15x7.5 hole
    // 56.5 from the right, 15 up; 34.5x14
}

module angled_rite(shell=0,depth=0) {
    translate([10,0,-45]) rotate([0,-15,0]) focusrite(shell,depth);
}
//angled_rite();




module bracket() {
    difference() { hull() {

    hull() { // back plate
        translate([-5,-50,0]) rotate([0,90,0]) difference() {
            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
        }
        translate([-5,50,0]) rotate([0,90,0]) difference() {
            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
        }
        translate([-5,-50,-30]) rotate([0,90,0]) difference() {
            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
        }
        translate([-5,50,-30]) rotate([0,90,0]) difference() {
            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
        }
    }

    difference() { // holder boundary
        angled_rite(shell=5,depth=-58);
        translate([-e,0,0]) angled_rite();
    }
    
    }
    
    translate([0,-150/2,-11]) cube([30,150,150]); // room for screw area
    translate([-e,0,0]) angled_rite(depth=5); // subtract focusrite
    translate([-5,-50,0]) rotate([0,90,0]) { // screw hole
            translate([0,0,-e]) cylinder(d=4.5,h=15+e); }
    translate([-5,50,0]) rotate([0,90,0]) { // screw hole
            translate([0,0,-e]) cylinder(d=4.5,h=15+e); }
    }
    
    
    difference() {
        angled_rite(shell=5);
        translate([-e,0,0]) angled_rite(depth=5);
    }
}
bracket();

module spacer() {
    difference() { hull() {

    hull() { // back plate
        translate([-5,-50,0]) rotate([0,90,0]) difference() {
            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
        }
//        translate([-5,50,0]) rotate([0,90,0]) difference() {
//            cylinder(d=14,h=5); translate([0,0,-e]) cylinder(d=4,h=15+e);
//        }
    }
    
    }
    
    translate([-5,-50,0]) rotate([0,90,0]) { // screw hole
            translate([0,0,-e]) cylinder(d=4.5,h=15+e); }
//    translate([-5,50,0]) rotate([0,90,0]) { // screw hole
//            translate([0,0,-e]) cylinder(d=4.5,h=15+e); }
    }
}
translate([0,0,100]) spacer();
translate([0,100,100]) spacer();


//screen();