$fn=60;

module plate() {
    width=48.5; // 47.5 actual
    translate([-width/2,-width/2]) color("silver") hull() {
        translate([0,(width-40)/2,0]) cube([width,40,2]);
        translate([(width-40)/2,0,0]) cube([40,width,2]);
    }
}

module pcb(holes=true) {
    w=25; // 24 actual
    l=68; // 67 actual
    // 7mm from bottom
    color("green") translate([-48.5/2-(l-48.5)+7.5,-w/2,4.5]) difference() {
        cube([l,w,1]);
        if(holes) {            
            translate([9,1.7,-2]) cylinder(d=2.24,h=20);
            translate([9,w-1.7,-2]) cylinder(d=2.24,h=20);
            translate([l-5,1.7,-2]) cylinder(d=2.24,h=20);
            translate([l-5,w-1.7,-2]) cylinder(d=2.24,h=20);
        }
    }
    color("silver") translate([+48.5/2,-9/2,0.7])
        cube([7.6,9,3.3]);
}

module coil() {
    color("black") translate([0,0,5.5]) cylinder(d=50,h=0.85);
    color("coral") translate([0,0,5.5+0.85-0.01]) difference() {
        cylinder(d=42,h=1.4);
        translate([0,0,-1]) cylinder(d=20.4,h=3);
    }
}
module cord() {
    // 7mm by 14
    translate([47.5/2+7,-7/2,0.7+(7/2-4)+3.3/2]) rotate([90,0,90]) {
        difference() {
            hull() {
                cylinder(d=7,h=75);
                translate([7,0,0]) cylinder(d=7,h=75);
            }
            translate([-7/2,-7,-1]) cube([14,7,90]);
        }
        translate([-7/2,-7,0]) cube([14,7,75]);
    }
}

module charger(holes=true) {
    plate();
    pcb(holes);
    coil();
}
module phone(cutout=0) { // top is to the -x direction
    distance_from_charger=1.2;
    if(cutout) {
        translate([-81-cutout/2,-(76.24-cutout)/2,9.6+distance_from_charger]) cube([150,76.24-cutout,12]);
    } else {
        color("grey",alpha=.5) translate([-81,-76.24/2,9.6+distance_from_charger]) cube([150,76.24,12]);
    }
}

module holder(animate=false) {
    position= -10+$t*25 ;
    difference() {
        union() {
            translate([-5,-5,-8.2-4.1]) minkowski() { cube([10,10,9.6+3.6+3]); phone(); }
            translate([-5+150/2,-5-76.24/2,-1.5]) cube([50,86.24,2]);
        }
        if(animate) {
            translate([-6,-6,position]) minkowski() { cube([12,12,20]); phone(); } // cut for development
        }
        linear_extrude(9.6) projection(cut=false) charger(holes=false); // 7mm -> 6mm actual
        // 8.2 desired * (7/6) = 9.6
        phone();
        translate([20,0,0]) phone();
        translate([20.01,0,4]) phone(cutout=20);
        cord();
    }
}
holder(true);
if ($t > 0.2) {
    charger();
}
//cube([1,1,8.2]);

translate([0,100,0]) holder();


//linear_extrude(7) projection(cut=false) charger(holes=false);