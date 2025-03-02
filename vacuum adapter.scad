$fn=360;

big = 13;
small = 9.3;
diffheight = (22.35-big)/2;
wall_thickness=2;

module adapter_shell() {

resize([22.35, 39.15,40])
    cylinder(d=22.35, h=40);
   
translate([0,0,40+diffheight ]) {
    cylinder(d1=big, d2=small, h=7);
    translate([0,0,7]) cylinder(d1=9.3, d2=big, h=(big-small)/2);
    translate([0,0,7+(big-small)/2]) cylinder(d1=13, d2=9.3, h=7);

    translate([0,0,14+(big-small)/2]) cylinder(d1=9.3, d2=big, h=(big-small)/2);
    translate([0,0,14+(big-small)]) cylinder(d1=13, d2=9.3, h=7);
}

hull() {
    translate([0,0,40+diffheight ]) {
        cylinder(d=big, h=0.01);
    }
    translate([0,0,40]) {
        resize([22.35, 39.15,0.01])
        cylinder(d=22.35, h=0.01);
    }
}

}

// we want a 45 degree max for the 

module vacuum_adapter() {
    difference() {
        adapter_shell();
        cylinder(d=small-wall_thickness, h=80);
        
        translate([0,0,-.01])
            resize([22.35-wall_thickness, 39.15-wall_thickness, 20])
            cylinder(d=22.35, h=20);
        intersection() {
            resize([22.35-wall_thickness, 39.15-wall_thickness, 40])
                cylinder(d=22.35, h=40);
            translate([0,0,20-0.01]) cylinder(d1=39.15, d2=7, h=22.35-7);
        }
    }
}



module hole() {
    hull() {
        translate([-4,-27/2,0]) linear_extrude(.01) hull() {
            circle(d=10);
            translate([0,21]) circle(d=10);
            translate([8,8]) circle(d=10);
            translate([7.5,27]) circle(d=10);
        }
        shrink=0;
        translate([-4,-27/2,14]) linear_extrude(.01) hull() {
            translate([shrink, shrink]) circle(d=10);
            translate([shrink,21-shrink]) circle(d=10);
            translate([8-shrink,8-shrink]) circle(d=10);
            translate([7.5-shrink,27-shrink]) circle(d=10);
        }
    }
}


module nozzle_shell_outer_big() {
    translate([-4,-27/2,0]) linear_extrude(.01) hull() {
            circle(d=10);
            translate([0,21]) circle(d=10);
            translate([8,8]) circle(d=10);
            translate([7.5,27]) circle(d=10);
    }
}

module nozzle_shell_outer_small(shrink) {
    translate([-4,-27/2,0]) linear_extrude(.01) nozzle_shell_outer_2d(shrink);
}

module nozzle_shell_outer_2d(shrink) {
    hull() {
        translate([0, shrink/2]) circle(d=10-shrink);
        translate([0,21-shrink/2]) circle(d=10-shrink);
        translate([8-shrink/2,8]) circle(d=10-shrink);
        translate([7.5-shrink/2,27-shrink/2]) circle(d=10-shrink);
    }
}

//translate([0,0,13]) #hole();

module oil_pan_adapter() {

difference() 
{
    hull() {
        nozzle_shell_outer_big();
        translate([0,0,15]) nozzle_shell_outer_small(3);
    }
    hull() {
        translate([0,0,-.01]) nozzle_shell_outer_small(2);
        translate([0,0,15.01]) nozzle_shell_outer_small(5);
    }
}
translate([0,0,-15+0.01])
difference() {
    hull() {
        nozzle_shell_outer_big();
        translate([0,0,15]) nozzle_shell_outer_big();
    }
    hull() {
        translate([0,0,-.01]) nozzle_shell_outer_small(2);
        translate([0,0,15.01]) nozzle_shell_outer_small(2);
    }
}

//translate([-4,-18.5,-15+0.01]) 
//rotate([-90,0,90]) rotate_extrude(angle=90) {
//    translate([5,0]) rotate([0, 0,-90])
//    difference() {
//        nozzle_shell_outer_2d(0);
//        nozzle_shell_outer_2d(2);
//    }
//}

difference() {
    translate([0,0,-25]) rotate([180,0,0]){
        cylinder(d1=big, d2=small, h=7);
        translate([0,0,7]) cylinder(d1=9.3, d2=big, h=(big-small)/2);
        translate([0,0,7+(big-small)/2]) cylinder(d1=13, d2=9.3, h=7);

        translate([0,0,14+(big-small)/2]) cylinder(d1=9.3, d2=big, h=(big-small)/2);
        translate([0,0,14+(big-small)]) cylinder(d1=13, d2=9.3, h=7);
    }
    hole2();
}

module hole2() {
    translate([0,0,0]) rotate([180,0,0]){
        cylinder(d=small-wall_thickness, h=70);
    }
}

difference() {
    hull() {
        translate([0,0,-25]) rotate([180,0,0]){
            cylinder(d=big, h=0.01);
        }
        translate([0,0,-15]) rotate([0,0,0]) nozzle_shell_outer_big();
    }
    hole2();
    hull() {
        translate([-.5,0,-15]) rotate([0,0,-10])
            resize([14,30,1]) cylinder(d=14,h=1);
        translate([0,0,-25]) rotate([180,0,0])
            cylinder(d=small-wall_thickness, h=0.01);
    }
}

}


vacuum_adapter();
translate([40,0,15]) rotate([180,0,0]) 
oil_pan_adapter();