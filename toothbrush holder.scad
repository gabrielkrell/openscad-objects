//$fn=360;
w = 15.63;
d = .6;

module toothbrush() {
    translate([0,d,0]) hull() {
        translate([w/2,8.8/2,-.001]) cylinder(d1=8.8,d2=6.5,h=10);
        translate([w/2,8.8/2+5,-.001]) cylinder(d=6.5,h=10);
    }
}

cube([w,d,51.75]);
difference() {
    cube([w,8.8/2+5+d,10-.01]);
    toothbrush();
}

//#color("grey") toothbrush();
//#color("grey") translate([0,d,0]) translate([w/2,8.8/2+5,-.001]) cylinder(d=6.5,h=10);