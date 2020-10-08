leg_width=30;    // width of wood that goes through brace
flange_width=10; // how far the flange flares out at the base
flange_height=4; // how tall the flange is
brace_height=40; // how tall whole brace is
wall_thickness=4;// how wide walls of brace around wood are
hole_dia=4;      // diameter of screw holes

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
    color("#f2c883") {
        translate([-56/2,-56/2,-14]) cube([56,1400,14]);
        rotate(90) translate([-56/2,-750,-28]) cube([56,1400,14]);
    }
}


module holes() {
    bump() quad_cylinders(
        leg_width + 2*flange_width - 4,
        hole_dia / 2,
        brace_height+1)
    union() {
        cylinder(
            d=hole_dia,
            h=flange_height+.01,
            $fn=fn);
        
        translate([1,0,flange_height])
            cylinder(
                d=2*hole_dia+1,
                h=brace_height,
                $fn=fn);
    }
}

module brace() {
    hull() {
        leg_cylinders(leg_width+wall_thickness, fillet_r,brace_height);
        leg_cylinders(leg_width+2*flange_width, hole_dia/2,flange_height);
        
    }
}

color("white") difference() {
    brace();
    union() {
        wood();
        holes();
    }
}