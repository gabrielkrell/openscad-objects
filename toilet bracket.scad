depth=30;
$fn=160;
x=9-2; // additional length for back brackets


module point(x,z,y=0,r=1,d=depth) {
    translate([x,y+depth/2,z])
    rotate([90,0,0])
    cylinder(r=r,h=d,center=true);
//    cube([1,depth,1], center=true);
}

module pairwise_hulls() {
    for (i=[0:$children-2]) {
        hull() children([i:i+1]);
    }
}

//projection() rotate([-90,0,0])
module rim() {
    color("#f2f7f7") union() {
        hull()
        pairwise_hulls() {
            point(12+3,-67,d=100);
            point(4,-4,r=5,d=100);
            point(42+x,-4,r=5,d=100);
            point(50+x,-35,d=100);
            point(43+x,-60,d=100);
        }
        intersection() {
            difference() {
    //            color("blue",alpha=.5)
                c();
    //            color("red",alpha=.2)
                translate([5,0,0]) c(.1);
            }
    //        color("black", alpha=.2)
            translate([-5,-50,-60]) cube([35,100,55.7]);
        }
    }
}

module spacer() {
    difference() {
        hull()
        pairwise_hulls() {
            point(12-5,-67);
            point(0-8,0+10);
            point(44+6+x,0+10);
            point(48+6+x,-35);
            point(42+6+x,-60);
        }
        color(alpha=.5) translate([0,0,-60-50/2]) cube([200,100,50], center=true);
    }
}

//projection() rotate([-90,0,0])
//difference() {
//    spacer();
//    rim();
//}

module c(w=0) {
    r=240; // change r to adjust how far the "tail end" flies out.
    translate([r-2.2/200*r,-50-w/2,r/10])
    rotate([-90,0,0])
    cylinder(r=r,h=100+w,$fn=300);
}


module curve(width, height, length, dh) {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    translate([-(r -dh), 0, -width/2]) rotate([0, 0, -a/2])
        rotate_extrude(angle = a, $fn=600, convexity=2)
        translate([r, 0, 0])
        translate([-20,25,0]) projection() rotate([-90,0,0])
        difference() {
            spacer();
            rim();
        }
}


//w = 70;       // width of rectangle
//h = 80;       // height of rectangle
//l = 10;      // length of chord of the curve
//dh = -0.2;           // delta height of the curve
curve(70, 80, depth, -.3);
//rotate(-10) translate([-2,22,0]) curve(70, 80, 30, -.5);