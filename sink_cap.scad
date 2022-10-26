hole_dia = 36.35;
hose_dia=13.31;
$fn=180;

module sink() {
    difference() {
        color("silver") translate([-100,-100,0]) cube([200,200,1.5]);
        translate([0,0,-1]) cylinder(d=hole_dia,h=5);
    }

    translate([0,0,-1]) rotate([67,0,0]) translate([0,2,-100]) cylinder(d=hose_dia,h=300);   
    
    
//    translate([10,0,-1]) rotate([67,0,0]) translate([0,2,-100]) cylinder(d=hose_dia,h=300);   
    //translate([0,0,-1]) rotate([67,0,270]) translate([0,2,-100]) cylinder(d=hose_dia,h=300);   
}

//sink();
#translate([0,0,-1]) rotate([67,0,0]) translate([0,2,-100]) cylinder(d=hose_dia,h=300);   

module plug() {
    
    difference() {
        union() {
            translate([0,0,hose_dia*.75]) resize([hole_dia+1,hole_dia+1,4]) sphere(d=hole_dia+1);
            cylinder(d=hole_dia+1, h=hose_dia*0.75);
            translate([0,0,-hose_dia*.75]) cylinder(d=hole_dia+1, h=hose_dia*0.75);
        }
        // hollow inside plug
        translate([0,0,-hose_dia*.76]) cylinder(d=hole_dia-1, h=hose_dia*1.5);

        #difference() { // "shadow" under hose (hose held up by the sink, needs gap so cap can be installed)
            translate([0,-hole_dia/2-0.5,-100]) cylinder(d=hose_dia,h=200);
            // exclude 
            translate([0,0,-hose_dia*.76]) cylinder(d=hole_dia-1.01, h=hose_dia*1.5+4);
        }
    }
}

difference() {
    plug();
    sink();
}