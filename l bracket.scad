$fn=60;

difference() {
    cube([20,40,5]);
    translate([10,35,0]) cylinder(d=5,h=10);
}
difference() {
    cube([20,5,40]);
    translate([10,10,35]) rotate([90,0,0]) cylinder(d=5,h=10);
}
hull() {
    cube([20,30,5]);
    cube([20,5,30]);
}