// this whole thing is in inch units

module birch() {
    color("#af692f") children();
}

module leg(height=34.5, width=19.5) {
    color("black") {
        translate([0,0,-height]) cube([2, 1/4, height]);
        translate([0,width,-height]) cube([2, 1/4, height]);
        translate([0,0,-height]) cube([2, width, 1/4]);
        translate([0,0,-1/4]) cube([2, width, 1/4]);
    }
}


module desk() {
    birch() {
        cube([6*12, 25, 1.5]);
        translate([6*12-24.5, -67, 0]) cube([24.5, 67, 1.5]);
    }
    translate([2.5, 2.5, 0]) leg();
    translate([6*12-2.5-4, 2.5, 0]) leg();
    translate([6*12-2.5-4, -19.5-2.5, 0]) leg();
    translate([6*12-2.5, -67+2.5, 0]) rotate([0,0,90]) leg();
}

translate([0,0,-1.5]) desk();


module long_shelf(length=6*12, height=10) {
    birch() translate([0, 25-9, height]) cube([length, 9, 1.5]);
    translate([2.5, 25-9+1.25, height]) leg(height=height, width=9-2.5);
    translate([length-2.5-2, 25-9+1.25, height]) leg(height=height, width=9-2.5);
}
long_shelf(height=7.25);

// 17.5 total height
// 14.5 leg height
// 7.25 each leg
translate([16*0,0,7.25+1.5]) long_shelf(length=6*12-16, height=7.25);

module round_shelf(height=10) {
    birch() translate([6*12, -67, height]) intersection() {
        cylinder(h=1.5, r=16);
        translate([-16, 0, 0]) cube([16,16,2]);
    }
    gap= 1.25; // gap between wall and leg
    translate([6*12-2-gap, -67+2+gap+gap, height]) leg(height=height, width=16-2-3*gap);
    translate([6*12-2-gap-gap, -67+gap, height]) rotate([0,0,90]) leg(height=height, width=16-2-3*gap);
}
round_shelf(7.25);

translate([0,0,7.25+1.5]) round_shelf(7.25);

module window() {
    translate([6*12-1, -37.5-8, -1.5]) {
        color("white") translate([0,1.5]) cube([1, 37.5-1.5*2, 50]);
        color("white") translate([-1.5,0,2.5]) cube([2.5, 37.5, 1]);
        color("blue") translate([-.1,5,5]) cube([1.1, 37.5-5*2, 40]);
    }
}
window();


module monitor() {
    translate([12*6-12,25-10,4]) rotate([0,0,-60]) {
        color("#333333") cube([21, .75, 12.5]);
        color("silver") translate([0,-1/8, 0]) cube([21, 1/8, 3/4]);
    }
}

translate([-4,-4,0]) monitor();
translate([-4,-4,14]) monitor();


module walls() {
    color("#d7faff") translate([-17,25,-34.5-1.5]) cube([6*12+17,6,8*12]);
    color("#d7faff") translate([6*12,-67,-34.5-1.5]) cube([6,67+25,8*12]);
    translate([-17,25-20,-34.5-1.5]) {
       color("#d7faff") cube([17,20,53.5-1.25]);
       color("white") translate([0,-.5,53.5-1.25]) cube([17+.5,20+1,1.25]);
    }
    color("#d7faff", alpha=.5) translate([-17-6,25-20-31,-34.5-1.5]) cube([6,31+20,8*12]);
     color("#d7faff", alpha=.5) translate([6*12-25-4,-67-6,-34.5-1.5]) cube([25+4,6,8*12]);
     color("white", alpha=.5) translate([6*12-25-4,-67,-34.5-1.5]) cube([4,1/2,7*12]);
}
walls();