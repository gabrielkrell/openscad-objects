$fn=360;

translate([0,0,35/2]) 
difference() {
    union() {
        hull() {
            translate([0,17.5,17.5]) cube([35,10,10], center=true);
            translate([0,17.5,-17.5]) cube([35,10,10], center=true);
            translate([0,-17.5-5,-17.5]) rotate([0,90,0]) cylinder(d=10,h=35, center=true);
//            translate([0,-17.5,17.5]) rotate([0,90,0]) cylinder(d=10,h=35, center=true);
        }
        hull () {
            difference() {
                translate([0,17.5+2.5,37.5]) rotate([0,90,0]) cylinder(d=10,h=35, center=true);
                translate([0,17.5+7.5,37.5]) cube([35.001,10,10], center=true);
            }
            translate([0,17.5+5-.5,37.5]) cube([35,1,10], center=true);
            translate([0,17.5,-17.5]) cube([35,10,10], center=true);
        }
        hull() {
            translate([0,-17.5-5,-17.5]) rotate([0,90,0]) cylinder(d=10,h=35, center=true);
            translate([0,-17.5-5,17.5]) rotate([0,90,0]) cylinder(d=10,h=35, center=true);
        }
            
    }
    
    

    hull() {
        translate([0,10,-10]) rotate([0,90,0]) cylinder(d=10,h=35.001, center=true);
        translate([0,-10-5,-10]) rotate([0,90,0]) cylinder(d=10,h=35.001, center=true);
        translate([0,10,50]) rotate([0,90,0]) cylinder(d=10,h=35.001, center=true);
        translate([0,-10-5,50]) rotate([0,90,0]) cylinder(d=10,h=35.001, center=true);
    }
    
//    d=30.001;
//    cube([35.1,d,d], center=true);
}

//translate([-30,22.25+$t,-10]) color("lightblue", alpha=.5) cube([60,5,80]);