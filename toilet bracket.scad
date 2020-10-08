depth=10;
fn=160;

module point(x,z,y=0,r=1,d=depth) {
    translate([x,y+depth/2,z])
    rotate([90,0,0])
    cylinder(r=r,h=d,center=true,$fn=fn);
//    cube([1,depth,1], center=true);
}

module pairwise_hulls() {
    for (i=[0:$children-2]) {
        hull() children([i:i+1]);
    }
}

//projection() rotate([-90,0,0])
module rim() {
    color("#f2f7f7") hull()
    pairwise_hulls() {
        point(12,-67,d=100);
        point(4,-4,r=5,d=100);
        point(42,-4,r=5,d=100);
        point(50,-35,d=100);
        point(43,-60,d=100);
    }
    intersection() {
        difference() {
            color("blue",alpha=.2) c();
            color("red",alpha=.2) translate([5,0,0]) c();
        }
        color("black", alpha=.2) translate([-5,0,-60]) cube([35,10,55]);
    }
}

module spacer() {
    difference() {
        hull()
        pairwise_hulls() {
            point(12-5,-67);
            point(0-8,0+10);
            point(44+6,0+10);
            point(48+6,-35);
            point(42+6,-60);
        }
        color(alpha=.5) translate([0,0,-60-50/2]) cube([200,100,50], center=true);
    }
}

projection() rotate([-90,0,0])
difference() {
    spacer();
    rim();
}

module c() {
    r=300;
    translate([r-4,0,r/10])
    rotate([-90,0,0])
    cylinder(r=r,h=depth,$fn=300);
}