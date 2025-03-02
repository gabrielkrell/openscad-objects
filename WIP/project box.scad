height=40;
wall = 3;
wall2 = wall * 2;

difference() {
    cube([60,60,height]);
    translate([wall,wall,wall]) cube([60-wall2,60-wall2,height]);
}

hull() {
    translate([-12,30-12/2,height-wall]) cube([12,12,wall]);
    translate([0,30-12/2,height/2-wall]) cube([wall,12,wall]);
}

hull() {
    translate([60,30-12/2,height-wall]) cube([12,12,wall]);
    translate([60-wall,30-12/2,height/2-wall]) cube([wall,12,wall]);
}