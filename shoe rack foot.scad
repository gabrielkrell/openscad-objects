$fn=220;

e=0.01;
e2=0.02;

module regular_polygon(radius, sides = 6, expand = false) {
    _r = radius / (expand ? cos(180 / sides) : 1);
    circle(r = _r, $fn = sides);
}



module foot() {
    difference() {
        cylinder(d=49.5, h=6.7);
        translate([0,0,-e]) cylinder(d=42.5, h=4.85-2.8+e);
    }
    translate([0,0,6.7-7.45]) cylinder(d=24.5, h=7.45);
}

color("grey")
difference() {
    foot();
//    #translate([0,0,6.7-7.45+1.88])
//        linear_extrude(5.36+e) regular_polygon(13/2,expand=true);
    #translate([0,0,6.7-7.45+1.88])
        hull() {
                linear_extrude(e) regular_polygon(13/2,expand=true);
            translate([0,0,5.58])
                linear_extrude(e) regular_polygon(13/2+.5,expand=true);
        }
    for (i = [0:360/6:360]) {
        rotate([0,0,i]) translate([(13/2)/cos(30),0,6.7-7.45+1.88]) cylinder(d=1,h=10);
    }
    translate([0,0,-10]) cylinder(d=4.5, h=20);
}