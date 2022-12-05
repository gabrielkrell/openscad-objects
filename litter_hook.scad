$fn=180;

module magnet() {
    difference() {
        cylinder(h=2.61,d=14.77);
        translate([0,0,-0.01]) cylinder(d=14.77-5.3*2, h=1.35+0.02);
        translate([0,0,1.35]) cylinder(d1=14.77-5.3*2, d2=14.77-4.17*2, h=2.61-1.35+0.01);
    }
    
}


module hook() {
    offset=250;
    translate([-19.5/2,5,0])
    rotate([90,0,0])
    translate([-offset,0,0]) rotate_extrude(angle=10, $fn=300)
    translate([offset,0]) polygon([
        [0,    0.5   ],
        [0,    9.5  ],
        [19.5, 10 ],
        [19.5, 0 ]
    ]);
}


module base() {
    difference() {
        hull() {
            translate([-25,-25,0]) union() { cylinder(d=5, h=4); translate([0,0,4]) resize([5,5,2]) sphere(d=5); }
            translate([25,-25,0]) union() { cylinder(d=5, h=4); translate([0,0,4]) resize([5,5,2]) sphere(d=5); }
            translate([-25,25,0]) union() { cylinder(d=5, h=4); translate([0,0,4]) resize([5,5,2]) sphere(d=5); }
            translate([25,25,0]) union() { cylinder(d=5, h=4); translate([0,0,4]) resize([5,5,2]) sphere(d=5); }
        }
        translate([-15,-15,-0.01]) hull() magnet();
        translate([15,-15,-0.01]) hull() magnet();
        translate([15,15,-0.01]) hull() magnet();
        translate([-15,15,-0.01]) hull() magnet();
    }
    
}

difference() {
    union() { base(); hook();} 
        translate([-18,3.5,2-0.01]) rotate([180,0,0]) linear_extrude(height=2) text(version, size=7);
}
