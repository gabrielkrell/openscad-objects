$fn=120;

module sponge() {
    color("blue") cube([112,80,22]);
}

module shelf_support(full=true) {
    translate([0,-3,-6]) cube([3,90*.4,3]);
    translate([120-3,-3,-6]) cube([3,90*.4,3]);
    if(full) {
        translate([120-3,-3,0.3]) cube([3,90*.4,3]);
        translate([0,-3,0.3]) cube([3,90*.4,3]);
    }
}

module shelf(r=3) {
    translate([0,0,-3]) difference() {        
        hull() {
            translate([0,0,0]) cube([1,1,3]);
            translate([120-1,0,0]) cube([1,1,3]);
            translate([r,90-r,0]) cylinder(h=3,r=r);
            translate([120-r,90-r,0]) cylinder(h=3,r=r);
        }
        intersection() {
            for(i=[0:10:150]) {
                rotate([0,0,10*0]) translate([i*1.2+10,-50,-1]) cube([5,150,5]);   
            }
            translate([10,10,-1]) cube([100,70,5]);
        }
    }
}

module screw_hole() {
    translate([0,-3.01,0]) rotate([90,0,180]) cylinder(d1=3.3, d2=7, h=3.1);
}

module base() {
    translate([0,0,28]) shelf_support();
    translate([0,0,56]) shelf_support();
    translate([0,0,84]) shelf_support(false);
    difference() {
        translate([0,-3,-3]) cube([120,3,84+3]);
        translate([20,0,40]) screw_hole();
        translate([100,0,40]) screw_hole();
    }
    translate([-3,-3,-3]) cube([3,90*.4,84+3]);
    translate([120,-3,-3]) cube([3,90*.4,84+3]);
    difference() {
        hull() {
            union() {
                shelf();
                translate([0,-3,-3]) cube([120,3,3]);
                translate([-3,-3,-3]) cube([3,90*.4,3]);
                translate([120,-3,-3]) cube([3,90*.4,3]);
            }
                
            translate([120/2-30/2, 90-30, -22]) rotate([-10,0,0]) cube([30,30,3]);
        }
        union() {
            hull() {
                translate([0,0,3]) shelf();
                translate([120/2-30/2, 90-30, -22+3]) rotate([-10,0,0]) cube([30,35,3]);
            }
            shelf();
        }
    }
}



base();
color("grey") shelf();
color("grey") translate([0,0,28]) shelf();
color("grey") translate([0,0,56]) shelf();
color("grey") translate([0,0,84]) shelf();
//translate([4,0,0]) sponge();
//translate([4,0,28]) sponge();
//translate([4,0,56]) sponge();
//translate([4,0,84]) sponge();