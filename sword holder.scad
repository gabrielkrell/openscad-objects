wall_thickness = 7.5;
height_back = 51.75; // height of back of hook as it touches the mounting surface
depth = 33+4.5/2; // wall-to-wall internal depth
height_front = 14; // from bottom of inner bracket to top of hook
width = 15.63;

if (!$preview) {
    $fn=360;
}

r = wall_thickness;
 // radii of inside space. r or r/2 are sensible defaults
inner_bl_r = 3;
inner_br_r = 15;

module finger() {
    translate([0,0,width/2]) rotate([0,90,0]) scale([23,9,9]) sphere(d=1,$fn=60);
}

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
    difference() {
    hull() {
        translate([r+inner_bl_r,r+inner_bl_r,0]) rotate(180) corner(r_=inner_bl_r,w=width+0.002);
        translate([depth+(r-inner_br_r),r+inner_br_r,0]) rotate(270) corner(r_=inner_br_r, w=width+0.002);
        translate([2*r,height_back-r,0]) rotate(90) corner(w=width+0.002);
        translate([depth,height_back-r,0]) corner(w=width+0.002);
    }
    union() {
        hull() {
            translate([wall_thickness,wall_thickness-4.5/2-.75,0]) rotate(270) finger();
            translate([wall_thickness+depth-inner_br_r,wall_thickness-4.5/2-.75,0]) rotate(270) finger();
        }
        x1 = wall_thickness+depth-inner_br_r;
        y1 = wall_thickness-4.5/2-.75+inner_br_r;
        for (a = [270 : 1 : 350]) {
            hull() {
            translate([x1+inner_br_r*cos(a),y1+inner_br_r*sin(a),0]) rotate(270) finger();
//            translate([x1+,y1,0]) rotate(270) finger();
            }
        }
    }
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

bracket();