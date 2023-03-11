fn=180; // 180 max?

module coaster(diameter) {
    minkowski() {
        translate([0,0,-.17]) // why is this necessary?
            cylinder(d=103-diameter,h=7.15-diameter, $fn=fn);
        translate([0,0,diameter/2]) sphere(d=diameter);
    }

    minkowski() {
        difference() {
            translate([0,0,-diameter*2/0]) cylinder(h=11.42-diameter,d=90.10-diameter, $fn=fn);
            translate([0,0,-1]) cylinder(d=70+diameter,h=999, $fn=fn);
        }
        translate([0,0,diameter/2]) sphere(d=diameter);
    }
    cylinder(d=79,h=11.42-2.23);
}

module box() {
    thickness=5;
    inside=105;
    translate([-inside/2-thickness,-inside/2-thickness,0]) 
    difference() {
        cube([inside+thickness*2,inside+thickness*2,55]);
        translate([thickness,thickness,thickness+4.5]) cube([inside,inside,70]);
    }
}

difference() {
    box();
    translate([0,0,11.42+5]) rotate([-180,0,0]) coaster(4);
}

//translate([0,0,11.42+5]) rotate([-180,0,0]) coaster(4);
//translate([0,0,11.42*2+5]) rotate([-180,0,0]) coaster(4);
//translate([0,0,11.42*3+5]) rotate([-180,0,0]) coaster(4);
//translate([0,0,11.42*4+5]) rotate([-180,0,0]) coaster(4);