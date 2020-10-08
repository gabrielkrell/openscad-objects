module spice(d1, h1, d2=0, h2=0, d3=3, h3=3) {
    cylinder(d=d1, h=h1);
    translate([0,0,h1-h2]) cylinder(d=d2, h=h2);
    cylinder(d=d3, h=h3);
}

module garam_masala() {
    color("blue")
    spice(47,107,50,12);
}

module nutmeg() {
    color("red")
    spice(43.5,108,45.5,27,45.5,23);
}

module sesame() {
    color("orange")
    spice(46,108,51,25.7,51,11);
}

module stonemill() {
    color("brown")
    spice(46.5,110.5,47.5,40.7,47.5,18.7);
}

module chinese() {
    color("purple") union() {
    translate([-36.5/2,-36.5/2,0]) cube([36.5,36.5,77]);
    translate([-39/2,-39/2,0]) cube([39,39,19]);
    translate([-39/2,-39/2,77-19]) cube([39,39,19]);
    translate([0,0,77]) cylinder(d=40,h=110-77);
    }
}

module target() {
    color("cyan")
    spice(45,56.3);
}

module mccormickhalf() {
    color("green")
    spice(44.15, 54, 0, 0 , 45.4, 40);
}

module random_spice() {
    choice = rands(0,7,1)[0];
    if (choice < 1) {
        garam_masala();
    } else if (choice < 2) {
        nutmeg();
    } else if (choice < 3) {
        sesame();
    } else if (choice < 4) {
        stonemill();
    } else if (choice < 5) {
        chinese();
    } else if (choice < 6) {
        target();
    } else {
        mccormickhalf();
    }
}

module big_spice() {
    chinese();
    color("grey") spice(51,300); // 110.5 real length
}

module tilt() {
    translate([0,0,25]) rotate([75,0,0]) children();
}

module holder_unit() {
    l=15;
    h=90;
    translate([-l/2,-100,0]) cube([l,l,h-2.5]);
    translate([-l/2,-100+2,h-2.5]) cube([l,l,2.5]);
    translate([-l/2,-50,0]) cube([l,l,h]);
    translate([0,l/2-50,38]) rotate([0,90,90]) cylinder(d=65,h=l,center=true);
    translate([0,l/2-100,50]) rotate([0,90,90]) cylinder(d=65,h=l,center=true);
    translate([-l,-100,0]) cube([2*l,100,5]);
}

for (x = [0 : 67 :600] ) {
    
    translate([x,0,0]) {
        tilt()   
            random_spice();
//            big_spice();
        difference() {
            holder_unit();
            union() {
                tilt() big_spice();
                translate([0,0,2.5-90]) holder_unit();
            }
        }
    }
}
