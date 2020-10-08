spacing = 15;
vial_dia = 7.75+0.5; // vial dia + spacing

module holes(dia, height) {
    for (i=[0:2]) {
        translate([0,spacing*i,0]) for (j=[0:4]) {
            translate([j*spacing,0,0])
            cylinder(d=dia, h=height, $fn=30);
        }
    }
}


module box() {
    difference() {
        union() {
            hull() holes(vial_dia + 4, 15);
            hull() holes(vial_dia + 5, 13);
        }
        translate([0,0,5]) holes(vial_dia, 15);
    }
}

module lid() {
    difference() {
        hull() holes(vial_dia + 5, 32+2);
        translate([0,0,-2]) hull() holes(vial_dia + 4, 32);
    }
}

box();
translate([0,50,32]) mirror([0,0,1]) 
lid();


//module test_holes(dia, height) {
//       for (j=[0:4]) {
//            translate([j*spacing,0,0])
//            cylinder(d=dia+0.25*j, h=height, $fn=30);
//        }
//}
//
//module test() {
//    difference() {
//        union() {
//            hull() test_holes(vial_dia + 4, 15);
//            hull() test_holes(vial_dia + 5, 13);
//        }
//        translate([0,0,5]) test_holes(vial_dia, 15);
//    }
//}
//
//test();