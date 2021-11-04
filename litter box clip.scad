width = 0.8;
length = 40;

module 2DEdge() {
    polygon(points = [
[0,     0],
[2.45,  0],
[3,     7.24],
[14.7,  7.24],
[15.8, -7.24],
[15.8-width, -7.24],
[14.7-width,  7.24-width],
[3   +width,  7.24-width],
[2.45+width,  0-width],
[0,           0-width],
],
convexity = 3);
}

module panEdge() {
    minkowski() {
        linear_extrude(length) 2DEdge();
        cylinder(d=0.5, center=true);
    }
}

module 2DclipTop() {
    right = 3;
    left = 3.5;
    translate([-left,0,0]) square([right+left, 13]);
}

module 2DclipArm() {
    left = 3;
    right = 6;
    up = 1;
    thickness = 3;
    difference() {
        translate([right/2-left/2,up]) circle(d=left + right);
        translate([right/2-left/2,up]) circle(d=left + right - thickness);
    }
}

module offset_extrude(length, offset=0) {
    translate([0,0,-offset]) linear_extrude(length+2*offset, convexity=2) children();
}

module clipTop() {
    difference() {
        offset_extrude(length, 0.01) 2DclipTop();
        panEdge();
    }
}

module clipArm() {
    difference() {
        offset_extrude(length) 2DclipArm();
        union() {
            hull() clipTop();
            panEdge();
        }
    }
}

module hash() {
    translate([2.6,8.5,30])
    rotate([90,90,90])
    linear_extrude(height=0.5)
    text(version, size=4);
}

module clip() {
    difference() {
        union() {
            clipTop();
            clipArm();
        }
        hash();
        cardboard();
    }
}


module cardboard() {
    // 3.57 thickness unsquished
    translate([-2,2,-1]) cube([3.4,60,length+2]);
}
    


clip();

rotate([90,0,0]) {
    clip();
    color("Gainsboro") panEdge();
    color("Peru") cardboard();
}

$fn=60;