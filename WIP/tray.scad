length = 177.8;
width = 50.8;
thickness=4;
ledge_height=10;
ledge_angle=12.5;

module tray() {
    cube([length,width,thickness]);

    rotate([ledge_angle,0,0])
    cube([length,thickness,ledge_height]);

    translate([length,width,0])
    rotate([0,0,180])
    rotate([ledge_angle,0,0])
    cube([length,thickness,ledge_height]);

    rotate([0,-ledge_angle,0])
    cube([thickness,width,ledge_height]);

    translate([length,width,0])
    rotate([0,0,180])
    rotate([0,-ledge_angle,0])
    cube([thickness,width,ledge_height]);
}

union() {
    tray();
    difference() {
        hull() tray();
        cube([length,width,ledge_height*2]);
    }
}