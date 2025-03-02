hole_dia=18.75;
wall_thickness=16.5;
plate_thickness=2;
plate_dia=30;

$fn=120;

module wall() {
    difference() {
        translate([-100,-100,0]) color("brown") cube([200,200,wall_thickness]);
        translate([0,0,-1]) cylinder(d=18,h=wall_thickness+2);
    }
}

//wall();

module main() {
    translate([0,0,-plate_thickness]) cylinder(d=plate_dia,h=plate_thickness);
    difference() {
        cylinder(d=18,h=wall_thickness*4.5);
        translate([0,0,wall_thickness*4.5 - 10]) rotate([90,0,0]) cylinder(d=10,h=20);
    }
}

module peg() {
    translate([0,0,wall_thickness*4.5 - 10]) rotate([90,0,0]) cylinder(d=10-0.5,h=20);
}

difference() {
    main();
    translate([-20,(plate_dia-hole_dia)/2,-30]) cube([40,20,wall_thickness*10]);
}
peg();
