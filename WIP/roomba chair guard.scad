// 40 wide 39 tall U shape with wings

module leg_section() {
    difference() {
        resize([40,39*2,20]) cylinder(h=20,d=40);
        translate([-100,-200,-50]) cube([200,200,200]);
    }
}

difference() {
    scale(1.3) leg_section();
    difference() {
        translate([0,4,-10]) resize([0,0,40]) leg_section();
        translate([16-7,4,0]) cube([4,5,40]);
        translate([-16+7-4,4,0]) cube([4,5,40]);
    }
    translate([-9,0,0]) cube([18,5,40]);
}

// a small cross-section fits around the chair leg, but this design won't flex enough to go on normally. Better to build an interlocking thing - two halves of the arch, with a plastic stick that goes through and is also the roomba buffer