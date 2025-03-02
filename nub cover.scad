//31 mm
//19 mm wide
//21.36 top to bottom
l=31;
w=19;
h=21.36;
thickness=1;
difference() {
    cube([l+thickness*1, w+thickness*2, h+thickness*2]);
    translate([thickness, thickness, thickness]) cube([l+thickness, w, h]);
}