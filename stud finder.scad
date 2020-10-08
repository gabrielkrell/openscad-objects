x=0.1; // tolerance for hole
$fn=60;

difference() {
    translate([-15,-15,0]) cube([30,30,3]);
    translate([0,0,0.4]) cylinder(h=10,d=6.39+x); // h=2.45 really
    translate([0,0,-.001]) cylinder(h=1,d=1);
}

hull() {
translate([ 7,0,16]) sphere(r=3);
translate([-7,0,16]) sphere(r=3);
}

difference() {
    hull() {
        translate([ 7,0,15]) sphere(r=2);
        translate([7,0,0]) cylinder(d=6,h=3);
        translate([-7,0,15]) sphere(r=2);
        translate([-7,0,0]) cylinder(d=6,h=3);
    }
    translate([0,0,3-.001]) cylinder(h=10,d=10,d2=7);
    translate([0,0,0.4]) cylinder(h=10,d=6.39+x); // h=2.45 really
    translate([0,0,-.001]) cylinder(h=1,d=1);
}
