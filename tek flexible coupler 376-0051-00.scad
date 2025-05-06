mm_per_inch=25.4;
in = mm_per_inch;
$fn=200;
e=0.01;


module flex_coupler_half() {
    difference() {
    union() {
            cylinder(d=6.24,h=4.5);
            translate([-1.5,-9.6/2,2.5]) cube([3,9.6,3.5]);
            hull() {
                translate([0,0,4.5+0.5]) cylinder(d=6.24,h=1);
                translate([-1.5,-9.6/2,2.5+3.5-1]) cube([3,9.6,1]);
            }
            // middle piece is 1mm thick, has 0.5mm gap
        }
        translate([-1.5-e,-9.6/2-e,2.5+3.5-1.5]) cube([3+e*2,9.6*3/4+e*2,0.5]);
        translate([-5,0,0.75+3.15/2]) rotate([0,90,0]) cylinder(d=3.15,h=10);
        translate([0,0,-e]) cylinder(d=3.2,h=4.5+e);
    }
}


module coupler_half() {
    color("#ababab", alpha=0.9) difference() {
        cylinder(d=3/8*in,h=3/16*in);
        translate([0,0,-0.01]) cylinder(d=1/4*in,h=1/4*in+0.02);
        translate([-9/64*in*.5,-3/8*in/2,3/32*in]) cube([9/64*in,3/8*in,1/8*in]);
        translate([-3/16*in,0,3/16*in/2]) rotate([0,90,0]) cylinder(d=7/64*in,h=3/8*in);
    }
    color("#616161", alpha=0.65) {
        translate([1/8*in,0,3/16*in/2]) rotate([0,90,0]) cylinder(d=7/64*in,h=3/16*in);
        translate([-1/8*in,0,3/16*in/2]) rotate([0,-90,0]) cylinder(d=7/64*in,h=3/16*in);
    }
        
}

flex_coupler_half();
translate([0,0,5.5*2]) rotate([180,0,0]) flex_coupler_half();

//coupler_half();
//translate([0,0,5.5*2]) rotate([180,0,0]) coupler_half();
