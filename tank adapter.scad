$fn=120;

module adapter() {
    cylinder(d=8.7,h=6.9);
    translate([0,0,6.9]) difference() {
        cylinder(d=15.05,h=8.21);
        translate([0,0,8.21-6.33+0.01]) cylinder(d=11.8,h=6.33);
    }
}

module insert() {
    translate([0,0,10.6]) rotate([90,0,0]) hull() {
        cylinder(d=3.5,h=15);
        translate([0,15,0]) cylinder(d=3.5,h=15);
    }
}

difference() {
    adapter();
    insert();
}