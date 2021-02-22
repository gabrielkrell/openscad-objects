$fn=30;

base_dia = 196.85;
base_r = base_dia/2;

module hexes() {
    d = 11;
    dx = d*cos(30);
    dy = d*sin(30);
    lx = -100;
    ly = -100;
    
    for(y = [ly:d:100]) {
        for(x = [lx     : 2*dx:100]) {
            translate([x,y,   -.001]) cylinder(h=3,r=5.5,$fn=6);
        }
        for(x = [lx + dx:2*dx:100]) {
            translate([x,y+dy,-.001]) cylinder(h=3,r=5.5,$fn=6);
        }
    }
}


module walls() {
        intersection() { // vert wall
            translate([-20,-base_r,0]) cube([2,base_dia,65]);
            translate([0,0,-.001]) cylinder(h=65,d=base_dia);
        }
        intersection() { // horiz wall
            translate([-base_r-20,-19,0]) cube([base_r,2,65]);
            translate([0,0,-.001]) cylinder(h=65,d=base_dia);
        }
}

module wall_borders() {
    intersection() {
        difference() { // ring
            cylinder(h=100,d=base_dia, $fn=300);
            translate([0,0,-.001]) cylinder(h=100.002,d=base_dia-4);
        }
        walls();
    }
    intersection() {
        translate([-100,-100,63]) cube([200,200,2]);
        walls();
    }
    intersection() {
        translate([-100,-100,0]) cube([200,200,2]);
        walls();
    }
    intersection() {
            translate([-20,-base_r,0]) cube([2,base_dia,65]);
            translate([-base_r-15,-19,0]) cube([base_r,2,65]);
    }
}

module base() {
    union() {    
        difference() { // hexes
            cylinder(h=2,d=base_dia);
            hexes();
        }
        difference() { // ring
            cylinder(h=2,d=base_dia, $fn=300);
            translate([0,0,-.001]) cylinder(h=2.002,d=base_dia-4);
        }
        difference() {            
            intersection() { // vert wall
                translate([-20,-base_r,0]) cube([2,base_dia,65]);
                translate([0,0,-.001]) cylinder(h=65,d=base_dia);
            }
            translate([-20,0,0]) rotate([0,90,0]) hexes();
        }
        difference() {
            intersection() { // horiz wall
                translate([-base_r-20,-19,0]) cube([base_r,2,65]);
                translate([0,0,-.001]) cylinder(h=65,d=base_dia);
            }
            translate([0,-17,0]) rotate([90,90,0]) hexes();
        }
        wall_borders();
    }
}


base();

module pegs() {
    d = 22;
    dx = d*cos(30);
    dy = d*sin(30);
    lx = -100;
    ly = -100;
    
    for(y = [ly:d:100]) {
        for(x = [lx     : 2*dx:100]) {
            translate([x,y,   -.001]) cylinder(h=35,d=5);
            translate([x,y,   -.001]) cylinder(h=2,r=5.5,$fn=6);
        }
        for(x = [lx + dx:2*dx:100]) {
            translate([x,y+dy,-.001]) cylinder(h=35,d=5);
            translate([x,y+dy,-.001]) cylinder(h=2,r=5.5,$fn=6);
        }
    }
}

intersection() {
    pegs();
    cylinder(h=100,d=base_dia-4);
    translate([-20,-base_r,0]) cube([200,base_dia,65]);
}

//translat([-6,-13,0]) color("red") cylinder(h=25,d=21);

    