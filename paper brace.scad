h=31.55;

hull() {
cube([2,2,h]);
translate([10,10,0]) cylinder(d=2,h=h, $fn=40);
translate([0,20-2,0]) cube([2,2,h]);
}
hull() {
translate([15,13,0]) cylinder(d=2,h=h, $fn=40);
translate([15,7,0]) cylinder(d=2,h=h, $fn=40);
translate([6,10,0]) cylinder(d=2,h=h, $fn=40);
}
cube([20,20,3]);
translate([0,0,h-3]) cube([20,20,3]);