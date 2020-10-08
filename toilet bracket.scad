depth=10;
fn=30;

module point(x,z,y=0) {
    translate([x,y+depth/2,z])
    rotate([90,0,0]) cylinder(r=1,h=depth,center=true);
//    cube([1,depth,1], center=true);
}

module pairwise_hulls() {
    for (i=[0:$children-2]) {
        hull() children([i:i+1]);
    }
}

pairwise_hulls() {
point(12,-67);
point(0,0);
point(43,0);
point(48,-35);
point(42,-60);
}