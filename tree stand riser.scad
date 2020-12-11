cylinder(h=20,d=25);
difference() {
    translate([0,0,20]) cylinder(d1=25,d2=19,h=10);
    translate([0,0,20.1]) cylinder(d=14,h=10);
}