$fn=300;

hole_offset=19.75;
// as determined by measuging 4.5 from the edge of the plate:
// 62/2-13.5/2-4.5

difference() {
    cylinder(h=24,d=57);
    translate([0,0,-0.01]) cylinder(h=5, d=2); // center hole in case it needs to be lathed
    for( i = [0:360/5:360] ) {
        rotate([0,0,i]) translate([hole_offset,0,-1]) cylinder(d=12.5,h=50);
        // 12mm diameter, 
    }
}
rotate([0,0,0]) difference() {
    translate([0,0,24]) cylinder(h=24,d=57);
    translate([0,0,48-2-0.01]) cylinder(h=2+0.02, d1=0, d2=2); // center indicator in case it needs to be lathed
    for( i = [0:360/5:360] ) {
        rotate([0,0,i]) translate([hole_offset,0,-1]) cylinder(d=11,h=50);
        // M10, leave a little extra room so it doesn't bind
    }
}


module cap() {
    difference() {
        cylinder(h=.5,d=62);
        for( i = [0:360/5:360] ) {
            rotate([0,0,i]) translate([hole_offset,0,-1]) cylinder(d=13.5,h=50);
        }
    }
}

//translate([0,0,-1]) color("silver") cap();

// 4.5 from the edge
//bolts are M10