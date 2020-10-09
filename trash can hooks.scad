wall_thickness = 2.5;
height_back = 28.6; // height of back of hook as it touches the mounting surface
depth = 2.5; // wall-to-wall internal depth
height_front = 15; // from bottom of inner bracket to top of hook
width = 15.5;
c = .2; // % of front_height to thicken bottom of hook by

//$fn=360;

r = wall_thickness;
 // radii of inside space. r or r/2 are sensible defaults
inner_bl_r = 1;
inner_br_r = 1;

module corner(r_=wall_thickness, w=width) {
    intersection() {
        cylinder(r=r_, h=w);
        cube([r_,r_,w]);
    }
}

module ul() { translate([0,height_back-r,0]) corner(); }
module bl() { translate([0,0,0]) rotate(0) corner(); }
module br() { translate([depth+r,r,0]) rotate(270) corner(); }
module ur() { translate([depth+r,height_front,0]) corner(); }

module inside() {
    translate([0,0,-0.001])
    hull() {
        translate([r+inner_bl_r,r+inner_bl_r+height_front*c,0]) rotate(180) corner(r_=inner_bl_r,w=width+0.002);
        translate([depth+(r-inner_br_r),r+inner_br_r+height_front*c,0]) rotate(270) corner(r_=inner_br_r, w=width+0.002);
        translate([2*r,height_back-r,0]) rotate(90) corner(w=width+0.002);
        translate([depth,height_back-r,0]) corner(w=width+0.002);
    }
}

module bracket() {
    difference() {
        union() {
            hull() {
                ul(); bl();
            }
            hull() {
                translate([-depth-r,0,0]) ur();
                bl(); br(); ur();
            }
        }
        inside();
    }
}


module trash_can(offset_h) {
    rim = 8.4;
    can_height = 234-8.36;
    y = offset_h;
    x = offset_h/can_height * ( 256-2*rim - 158) / 2;
    translate([rim-256/2+x,width/2,offset_h])
    hull() {
        resize([256-2*rim, 183.5-2*rim,4]) cylinder(d=183.5,h=1);
        translate([0,0,-can_height]) resize([158, 105, 4]) cylinder(d=105,h=1);
    }
}

module hook_1() {
    difference() {
        rotate([0,10,0]) union() {
            translate([0,0,height_back]) rotate([-90,0,0]) bracket();
            translate([-2,0,0]) cube([2, width, height_back]);
        }
        translate([0,0,0]) #trash_can(height_back+145);
    }
}

module trash_can_1() {
    translate([-246/2,width/2,-135 - height_back + wall_thickness])
    difference() {
        cylinder(r=246/2, h=375);
        translate([0,0,2.54]) cylinder(r=246/2-2.54, h=375-2.54+0.002);
    }
}

module hook_2() {
    difference() {
        union() {
            translate([0,0,height_back]) rotate([-90,0,0]) bracket();
            translate([-2,0,0]) cube([2, width, height_back]);
        }
        #trash_can_1();
    }
}

hook_1();
translate([0,250,0]) hook_2();