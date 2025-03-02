$fn=120;
s = 0.01;

module sample() {
    color("grey") cylinder(d=8, h=51);
    color("black") hull() {
        translate([0,0,51-2-8.78+4]) cylinder(d=2.2,h=8.78-4);
        translate([4+2.2/2,0,51-2-8.78+4]) cylinder(d=2.2,h=8.78-4);
    }
    color("black") translate([4+2.2/2,0,51-2-8.78]) cylinder(d=2.2,h=8.78);
    color("black") translate([0,0,51-2-8.78+4]) cylinder(d=8.1,h=8.78-4+2+s);
}

sample();