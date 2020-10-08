leg_width=30;    // width of wood that goes through brace
flange_width=10; // how far the flange flares out at the base
flange_height=4; // how tall the flange is
brace_height=40; // how tall whole brace is
wall_thickness=4;// how wide walls of brace around wood are
hole_dia=3.5;      // diameter of screw holes

fillet_r=1.5;    // radius of curve on corners
fn=60;           // cylinder smoothness

module bump(d=-0.01) { translate([0,0,d]) children(); }

module quad_cylinders(leg_width_, fillet_r_,brace_height_) {
    t_d = leg_width_ - 2*fillet_r_; // translation distance between cylinders
    t_r = sqrt(2 * pow(t_d/2,2)); // distance from center
    
    rotate(45) for (i=[0:3])
        rotate(90*i)
        translate([t_r,0,0])
        children();
}

module leg_cylinders(leg_width_, fillet_r_,brace_height) {
    quad_cylinders(leg_width_, fillet_r_,brace_height)
    cylinder(r=fillet_r, h=brace_height, $fn=fn);
}

module wood() {
    color("#47443f")
        bump()
        hull()
        leg_cylinders(leg_width, fillet_r,275);
    slat();
    crossbar();
}

module slat() {
    color("#f2c88355") translate([-56/2,-56/2,-14]) cube([56,1400,14]);
}

module crossbar() {
    color("#f2c88355") rotate(90) translate([-56/2,-750,-28]) cube([56,1400,14]);
}


module brace() {
    hull() {
        leg_cylinders(leg_width+wall_thickness, fillet_r,brace_height);
        leg_cylinders(leg_width+2*flange_width, hole_dia/2,flange_height);
        platforms();
    }
}

module platforms() {
    translate([0,56,0]) rotate(90) platform();
    translate([56/2,0,-14]) platform();
    translate([-56/2,0,-14]) rotate(180) platform();
}
module platform() {
    difference(){hull() leg_cylinders(leg_width+wall_thickness, fillet_r, flange_height);
    platform_hole();}
}

module platform_hole() {
    translate([(leg_width+wall_thickness)/4,0,0])
        cylinder(
            d=hole_dia,
            h=flange_height+.01,
            $fn=fn);
    translate([(leg_width+wall_thickness)/4,0,flange_height])
        cylinder(
            d=9,
            h=brace_height,
            $fn=6);
}
module platform_holes() {
    translate([0,56,0]) rotate(90) platform_hole();
    translate([56/2,0,-14]) platform_hole();
    translate([-56/2,0,-14]) rotate(180) platform_hole();
}
        
    

color("white") difference() {
    brace();
    union() {
        wood();
        bump() slat();
        platform_holes();
    }
}

wood();



// ===========================



difference() {
    bump(-2)
//    hull()
    {
        bottom_holes(15,30);
        hull() {
            color("blue") translate([-60/2,56/2,-14]) cube([2,5,2]);
            color("red") translate([-60/2,56,-14]) cube([2,5,2]);
        }
        hull() {
            color("blue") translate([28,56/2,-14]) cube([2,5,2]);
            color("red") translate([28,56,-14]) cube([2,5,2]);
        }
        hull() {
            color("red") translate([-60/2,56,-14]) cube([2,5,2]);
            translate([-60/2,56,]) cube([2,5,2]);
        }
        hull() {
            color("red") translate([28,56,-14]) cube([2,5,2]);
            translate([28,56,]) cube([2,5,2]);
        }
        hull() {
            translate([0,56,0-14]) rotate(90) bottom_hole(15,30);
            color("red") translate([-60/2,56,-14]) cube([2,5,2]);
            color("red") translate([28,56,-14]) cube([2,5,2]);
            translate([-56/2,56/2-7,-28]) cube([56,5,2]);
            color("blue") translate([-60/2,56/2,-14]) cube([2,5,2]);
            color("blue") translate([28,56/2,-14]) cube([2,5,2]);
        }
        hull() {
            translate([0,56,0-14]) rotate(90) bottom_hole(15,30);
            translate([56/2,0,-14-14]) bottom_hole(15,30);
            translate([-56/2,0,-14-14]) rotate(180) bottom_hole(15,30);
            translate([-56/2,56/2-7,-28]) cube([56,5,2]);
        }
    }
    union() {
        bump(-8) bottom_holes(h=10);
        wood();
    }
}


//        bump(-7) bottom_holes(h=7);

module bottom_hole(d=9,fn=6,h=2) {
    translate([(leg_width+wall_thickness)/4,0,0])
        cylinder(
            d=d,
            h=h,
            $fn=fn);
}
module bottom_holes(d=9,fn=6,h=2) {
    translate([0,56,0-14]) rotate(90) bottom_hole(d,fn,h);
    translate([56/2,0,-14-14]) bottom_hole(d,fn,h);
    translate([-56/2,0,-14-14]) rotate(180) bottom_hole(d,fn,h);
}

