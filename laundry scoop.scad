//47.3176
//78.8627455
//
//45 80

//cube([30,60,25]);
difference() {
    union() {
        translate([-1,-1,-1]) cube([32,62,45]);
        translate([-1,61,33]) rotate([0,90]) resize([32,16,32]) cylinder(d=16,$fn=3,h=32);
    }
    cube([30,60,430]);
    translate([-.2,-.2,25]) cube([30.4,60.4,460]);
}
translate([-1,61,40]) cube([32,32,4]);