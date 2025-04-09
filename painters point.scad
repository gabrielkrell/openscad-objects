e=0.01;
wall = 2.5;
totalDim = 25.5 + wall * 2;


module sawhorse() {
    color("grey") translate([-100,-25.5/2,-e]) cube([200,25.5,25.5]);
}


module point() {
    translate([-totalDim/2, -totalDim/2,0]) cube(totalDim);
    translate([-totalDim/2, -totalDim/2,totalDim]) hull() {
         cube([totalDim, totalDim, 0.01]);
         translate([totalDim/2,totalDim/2,totalDim*1/2]) sphere(r=e);
     }
    translate([-totalDim/2, -totalDim/2,-e]) hull() {
        cube([totalDim,wall*2,e]);
        translate([-0, 0,-wall*2]) cube([totalDim,e,e]);
    }
    translate([-totalDim/2, totalDim/2-wall*2,-e]) hull() {
        cube([totalDim,wall*2,e]);
        #translate([-0, wall*2,-wall*2]) cube([totalDim,e,e]);
    }
}

rotate([0,90,0]) {
    difference() {
        point();
        sawhorse();
    }
//    sawhorse();
}